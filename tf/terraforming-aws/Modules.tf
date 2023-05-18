module "aws" {
  source             = "./aws"
  env                = var.env
  access_key         = var.access_key
  secret_key         = var.secret_key
  rancher_dbusername = var.rancher_dbusername
  rancher_dbpassword = var.rancher_dbpassword
  cidr_block         = var.cidr_block
  ssh_public_key     = var.ssh_public_key
}