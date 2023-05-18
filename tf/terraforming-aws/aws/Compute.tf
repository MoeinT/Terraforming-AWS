
data "aws_ami" "server_ami" {

  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230328"]
  }
}

module "AllInstances" {
  source = "../../CommonModules/AWSInstance"
  auth   = local.auth

  ssh = {
    "key_name"   = "sshKey",
    "public_key" = var.ssh_public_key
  }

  AllInstances = {
    ec2-instance-01 = {
      "ami"                           = data.aws_ami.server_ami.id,
      "instance_type"                 = "t3.micro",
      "vpc_security_group_ids"        = [module.SecurityGroups.SecurityGroup_ids["sgpublic01"]],
      "subnet_id"                     = module.Subnets.subnet-ids["subnet-public-01"]
      "root_block_device_volume_size" = 10
    }
  }
}