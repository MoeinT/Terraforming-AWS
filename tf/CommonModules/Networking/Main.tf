terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_vpc" "AllVPCs" {
  for_each = var.allVPCs

  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support   = each.value.enable_dns_support

  tags = {
    Name = each.key
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_default_route_table" "default_rt" {
  for_each               = aws_vpc.AllVPCs
  default_route_table_id = aws_vpc.AllVPCs[each.key].default_route_table_id

  tags = {
    Name = aws_vpc.AllVPCs[each.key].tags_all.Name
  }
}