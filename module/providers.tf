terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_context_cluster = module.eks_cluster.eks_cluster.name
}
