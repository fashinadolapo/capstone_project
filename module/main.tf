
module "vpc" {
  source = "./modules/vpc"

  region               = var.region
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

# Create EKS cluster
module "eks" {
  source = "./modules/eks"

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
  source = "./modules/eks"

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
