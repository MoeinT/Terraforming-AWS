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

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}