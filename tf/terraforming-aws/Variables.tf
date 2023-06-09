variable "env" {
  description = "Environment for resources"
  type        = string
  validation {
    condition     = contains(["staging", "prod"], var.env)
    error_message = "Environment should be either staging or prod."
  }
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

variable "cidr_block" {
  type      = string
  sensitive = true
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}