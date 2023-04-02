variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "my-eks-cluster"
}

variable "instance_type" {
  description = "The instance type for the worker nodes."
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "The desired number of worker nodes."
  type        = number
  default     = 3
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created."
  type        = string
}

variable "private_subnets" {
  description = "The IDs of the private subnets where the EKS worker nodes will be launched."
  type        = list(string)
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the EKS cluster."
  type        = string
  default     = "1.20"
}

variable "bucket_name" {
  description = "The name of the S3 bucket used for Terraform state storage."
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table used for Terraform state locking."
  type        = string
}
