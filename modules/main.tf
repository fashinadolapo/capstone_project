# Create VPC
module "vpc" {
  source = "./vpc"

  region               = var.region
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

# create security groups
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.vpc_cidr
}

# create keypairs
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = "deployer-one"
  create_private_key = true
}

# Create ec_2 instance
module "ec2_instance" {
  source = "./ec2"

  for_each = toset(["one", "two", "three", "four", "five"])

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

  cluster_name            = var.cluster_name
  subnets                 = var.public_subnets
  vpc_id                  = var.vpc_id
  create_eks_service_role = true
  kubernetes_version      = var.kubernetes_version
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create worker nodes
module "eks_workers" {
  source = "./eks"

  cluster_name                    = var.cluster_name
  subnets                         = var.public_subnets
  instance_type                   = var.instance_type
  desired_capacity                = var.desired_capacity
  create_worker_security_group    = true
  additional_security_group_ids   = [module.vpc.vpc_default_security_group_id]
  additional_security_group_names = ["eks-workers-sg"]
  kubelet_extra_args              = "--node-labels=env=dev"
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

  versioning = {
    enabled = true
  }
}

# Create dynamodb-table
module "dynamodb_table" {
  source = "./s3$db"

  name     = var.my-table
  hash_key = "id"

  attribute = [
    {
      name = "id"
      type = "N"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id          = "vpc-abcde012"
  subnets         = ["subnet-abcde012", "subnet-bcde012a"]
  security_groups = ["sg-edcd9784", "sg-edcd9785"]

  access_logs = {
    bucket = "my-alb-logs"
  }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-0123456789abcdefg"
          port      = 80
        }
        my_other_target = {
          target_id = "i-a1b2c3d4e5f6g7h8i"
          port      = 8080
        }
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}

