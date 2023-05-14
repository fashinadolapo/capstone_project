# Create VPC
module "vpc" {
  source = "./vpc"

  region               = var.region
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

# Create ec_2 instance
module "ec2_instance" {
  source  = "./ec2"
  
  for_each = toset(["one", "two", "three","four", "five"])

  name = "instance-${each.key}"

  ami                    = "ami-005e54dee72cc1d00"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["aws_security_group.allow_tls.id"]
  subnet_id              = aws_subnet.public[count.index].id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create EKS cluster
module "eks" {
  source = "./eks"

  cluster_name              = var.cluster_name
  subnets                   = var.public_subnets
  vpc_id                    = var.vpc_id
  create_eks_service_role   = true
  kubernetes_version        = var.kubernetes_version
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create worker nodes
module "eks_workers" {
  source = "./eks"

  cluster_name              = var.cluster_name
  subnets                   = var.public_subnets
  instance_type             = var.instance_type
  desired_capacity          = var.desired_capacity
  create_worker_security_group = true
  additional_security_group_ids = [module.vpc.vpc_default_security_group_id]
  additional_security_group_names = ["eks-workers-sg"]
  kubelet_extra_args = "--node-labels=env=dev"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create s3 bucket
module "s3_bucket" {
  source = "./s3$db"

  bucket = var.bucket_name
  acl    = "private"

  versioning =  {
    enabled  = true
  }
}

# Create dynamodb-table
module "dynamodb_table" {
  source = "./s3$db"

  name     = var.my-table
  hash_key = "id"

  attribute =  [
    {
      name  = "id"
      type  = "N"
    }
 ]

 tags = {
   Terraform   = "true"
   Environment = "dev"
 }

}
