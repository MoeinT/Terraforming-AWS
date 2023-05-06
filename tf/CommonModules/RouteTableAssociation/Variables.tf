variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "RouteTableAssociations" {
  type = any
}

variable "auth" {
  type = map(string)
}