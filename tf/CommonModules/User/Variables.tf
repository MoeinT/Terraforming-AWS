variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "usernames" {
  type = list(string)
}

variable "auth" {
  type = map(string)
}