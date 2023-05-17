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

# Target Group
resource "aws_lb_target_group" "AllTargetGroups" {

  for_each = var.AllTargetGroups

  name     = each.key
  port     = each.value.port
  protocol = each.value.protocol
  vpc_id   = each.value.vpc_id

  dynamic "health_check" {
    for_each = each.value.health_check
    content {
      healthy_threshold   = health_check.value.healthy_threshold
      unhealthy_threshold = health_check.value.healthy_threshold
      timeout             = health_check.value.timeout
      interval            = health_check.value.interval
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = each.key
  }
}