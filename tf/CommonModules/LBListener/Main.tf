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

# Load Balancer Listener
resource "aws_lb_listener" "AllListeners" {

  for_each = var.AllListeners

  load_balancer_arn = each.value.load_balancer_arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = lookup(each.value, "ssl_policy", null)
  certificate_arn   = lookup(each.value, "certificate_arn", null)

  default_action {
    type             = each.value.default_action_type
    target_group_arn = each.value.target_group_arn
  }

  tags = {
    Name = each.key
  }
}