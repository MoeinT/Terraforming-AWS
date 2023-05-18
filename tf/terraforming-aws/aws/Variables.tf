variable "env" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "cidr_block" {
  type      = string
  sensitive = true
}

variable "ingress_access_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "egress_access_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}

variable "rancher_dbusername" {
  type      = string
  sensitive = true
}

variable "rancher_dbpassword" {
  type      = string
  sensitive = true
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "rancher_dbname" {
  type    = string
  default = "rancher"
}