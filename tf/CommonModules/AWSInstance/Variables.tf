variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "AllInstances" {
  type = map(any)
}

variable "ssh" {
  type = map(any)
}

variable "auth" {
  type = map(string)
}