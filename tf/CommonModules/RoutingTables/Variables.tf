variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "routingTables" {
  type = map(any)
}

variable "default_gateway_id" {
  type = string
}
variable "auth" {
  type = map(string)
}