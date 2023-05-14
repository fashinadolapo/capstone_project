provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_context_cluster = aws_eks_cluster.eks_cluster.name
}
