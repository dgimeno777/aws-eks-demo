locals {
  resource_name_prefix = "eks-demo"
  resource_name_suffix = terraform.workspace
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile"
  default     = "dgimeno"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "IDs of Subnet to associate with EKS cluster"
}
