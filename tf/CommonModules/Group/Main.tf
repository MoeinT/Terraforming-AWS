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
  region     = var.aws_region
  access_key = var.auth.access_key
  secret_key = var.auth.secret_key
}

/* Creating Groups */
resource "aws_iam_group" "AllGroups" {
  for_each = toset(var.groups)

  name = each.key
}