# Create EKS cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name              = var.cluster_name
  subnets                   = var.private_subnets
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
  source = "terraform-aws-modules/eks/aws//modules/eks-workers"

  cluster_name              = var.cluster_name
  subnets                   = var.private_subnets
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

# Configure S3 bucket for Terraform state storage
terraform {
  backend "s3" {
    bucket = var.bucket_name
    key    = "terraform.tfstate"
    region = var.region
    dynamodb_table = var.dynamodb_table_name
    encrypt        = true
  }
}

# Create DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = var.dynamodb_table_name
  hash_key     = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
type = "S"
}

ttl {
attribute_name = "TTL"
enabled = true
}
}
   
