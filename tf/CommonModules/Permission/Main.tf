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

/* Permissions to Groups */
resource "aws_iam_group_policy_attachment" "AllGroupPermissions" {
  for_each   = var.groupPermissions
  group      = each.key
  policy_arn = each.value
}