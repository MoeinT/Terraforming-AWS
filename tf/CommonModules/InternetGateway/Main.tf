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

/*Creating a user*/
resource "aws_internet_gateway" "allInternetGateways" {
  for_each = var.internetGateways
  vpc_id   = each.value.vpc_id

  tags = {
    Name = each.key
  }
}