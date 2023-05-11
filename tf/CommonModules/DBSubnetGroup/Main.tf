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

# All Database Subnet Groups

resource "aws_db_subnet_group" "DBSubnetGroups" {

  for_each    = var.DBSubnetGroups
  description = contains(keys(each.value), "description") ? each.value.description : "Database Security Group for RDS instances"
  name        = each.key
  subnet_ids  = each.value.subnet_ids

  tags = {
    Name = each.key
  }
}