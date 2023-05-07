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

# All Security Groups
resource "aws_security_group" "allSecurityGroups" {

  for_each = var.security_groups

  name        = each.key
  description = contains(keys(each.value), "description") ? each.value.description : null
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      description = contains(keys(ingress.value), "description") ? ingress.value.description : null
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = each.value.egress.from_port
    to_port     = each.value.egress.to_port
    protocol    = each.value.egress.protocol
    cidr_blocks = each.value.egress.cidr_blocks
  }

  tags = {
    Name = each.key
  }
}