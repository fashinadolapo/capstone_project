variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "The instance type for the EC2 instances."
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The AMI ID for the EC2 instances."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch the instances in."
  type        = list(string)
  default     = []
}

variable "instance_names" {
  description = "A list of names for the EC2 instances."
  type        = list(string)
  default     = []
}
