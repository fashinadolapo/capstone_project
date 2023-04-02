provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_context_cluster = module.eks_cluster.eks_cluster.name
}
