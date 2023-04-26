terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "eu-west-3"
  access_key = "AKIAZPQIKUV64DLWBON4"
  secret_key = "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"
}