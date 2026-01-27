variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
}
variable "email" {
  type    = string
  default = null
}

variable "cli_user_name" {
  type = string
}
