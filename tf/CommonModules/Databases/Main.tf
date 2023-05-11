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

# All RDS Instances
resource "aws_db_instance" "AllDBInstances" {
  for_each = var.AllDBInstances

  allocated_storage      = each.value.allocated_storage
  db_name                = each.value.db_name
  engine                 = "mysql"
  engine_version         = each.value.engine_version
  instance_class         = each.value.instance_class
  username               = each.value.username
  password               = each.value.password
  identifier             = each.value.identifier
  db_subnet_group_name   = each.value.db_subnet_group_name
  vpc_security_group_ids = each.value.vpc_security_group_ids
  skip_final_snapshot    = each.value.skip_final_snapshot

  tags = {
    Name = each.key
  }
}