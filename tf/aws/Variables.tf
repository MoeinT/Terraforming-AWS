variable "env" {
  type = string
}

variable "aws_region" {
  type      = string
  sensitive = false
  default   = "eu-west-3"
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}