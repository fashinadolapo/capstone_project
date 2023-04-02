region               = "us-west-2"
vpc_cidr             = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
eks_cluster_name     = "my-eks-cluster"
eks_worker_instance_type = "t3.medium"
eks_worker_desired_capacity = 3
s3_bucket_name       = "my-terraform-state-bucket"
dynamodb_table_name  = "my-terraform-state-locking-table"
kubernetes_version   = "1.20"
