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

# Creating a user
resource "aws_route_table" "allRoutingTables" {
  for_each = var.routingTables
  vpc_id   = each.value.vpc_id

  tags = {
    Name = each.key
  }
}

# Default route associated with each routing table created
resource "aws_route" "default" {
  for_each               = aws_route_table.allRoutingTables
  route_table_id         = aws_route_table.allRoutingTables[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.default_gateway_id
}