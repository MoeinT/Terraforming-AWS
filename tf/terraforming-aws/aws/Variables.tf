variable "env" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "cidr_block" {
  type    = string
  default = "10.123.0.0/16"
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

variable "dbusername" {
  type      = string
  sensitive = true
}

variable "dbpassword" {
  type      = string
  sensitive = true
}