module "aws" {
  source         = "./aws"
  env            = var.env
  access_key     = var.access_key
  secret_key     = var.secret_key
  dbusername     = var.dbusername
  dbpassword     = var.dbpassword
  cidr_block     = var.cidr_block
  ssh_public_key = var.ssh_public_key
}