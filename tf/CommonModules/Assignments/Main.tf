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

/* Assigning Users to Groups */
resource "aws_iam_user_group_membership" "AllAssignments" {
  for_each = var.userGroups
  user     = each.key
  groups   = each.value
}