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

# SSH Key for all Instances
resource "aws_key_pair" "ec2_auth" {
  key_name   = var.ssh.key_name
  public_key = var.ssh.public_key
}

resource "aws_instance" "AllInstances" {

  for_each = var.AllInstances

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  vpc_security_group_ids = each.value.vpc_security_group_ids
  subnet_id              = each.value.subnet_id
  key_name               = aws_key_pair.ec2_auth.id

  root_block_device {
    volume_size = each.value.root_block_device_volume_size
  }

  tags = {
    Name = each.key
  }
}