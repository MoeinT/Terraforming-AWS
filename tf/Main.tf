terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "tfstate-backend-terraform"
    region         = "eu-west-3"
    key            = "global/s3/staging.tfstate"
    dynamodb_table = "terraform_state_locking"
    encrypt        = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}