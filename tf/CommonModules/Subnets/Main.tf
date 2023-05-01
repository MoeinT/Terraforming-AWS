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

/* Create a Subnet ID */
resource "aws_subnet" "allSubnets" {

  for_each = var.allSubnets

  vpc_id                  = each.value.vpc_id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  availability_zone       = each.value.availability_zone

  tags = {
    Name = each.key
  }
}