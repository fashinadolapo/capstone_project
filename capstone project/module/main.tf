
module "vpc" {
  source = "./modules/vpc"

  region               = var.region
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

module "eks_cluster" {
  source = "./modules/eks_cluster"

  cluster_name           = var.eks_cluster_name
  kubernetes_version     = var.kubernetes_version
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  public_subnet_ids      = module.vpc.public_subnet_ids
}

module "eks_workers" {
  source = "./modules/eks_workers"

  cluster_name              = var.eks_cluster_name
  instance_type             = var.eks_worker_instance_type
  desired_capacity          = var.eks_worker_desired_capacity
  additional_security_group_ids =
