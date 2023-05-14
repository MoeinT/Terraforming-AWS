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

resource "aws_lb" "allLoadBalancers" {

  for_each = var.allLoadBalancers

  name               = each.key
  internal           = lookup(each.value, "internal", false)
  load_balancer_type = each.value.load_balancer_type
  security_groups    = each.value.security_groups
  subnets            = each.value.subnets
  idle_timeout       = lookup(each.value, "idle_timeout", 400)

  enable_deletion_protection = lookup(each.value, "enable_deletion_protection", true)

  tags = {
    Name = each.key
  }
}