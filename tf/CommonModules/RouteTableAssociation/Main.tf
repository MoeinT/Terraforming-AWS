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

# Associating route tables to subnets
resource "aws_route_table_association" "allRtAssociations" {

  for_each = var.RouteTableAssociations

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
}