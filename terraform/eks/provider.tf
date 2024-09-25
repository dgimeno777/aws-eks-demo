
terraform {
  backend "s3" {
    # Variables not allowed so hardcode
    key     = "aws-eks-demo/eks/terraform.tfstate"
    region  = "us-east-1"
    profile = "dgimeno"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
