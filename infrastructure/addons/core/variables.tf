variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "godaddy_api_key" {
  type = string
}

variable "godaddy_api_secret" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "email" {
  type    = string
  default = null
}

variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
}
