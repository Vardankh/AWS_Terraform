# Setting up aws provider and the region.

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.33.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
