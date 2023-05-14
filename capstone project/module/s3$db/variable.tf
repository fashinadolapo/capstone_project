variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for Terraform state."
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "table_name" {
  description = "The name of the DynamoDB table for Terraform state locking."
  type        = string
  default     = "my-terraform-state-locking-table"
}
