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

variable "cli_user_name_2" {
  type = string
}

variable "repository_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "repository_name" {
  description = "GitHub repository name"
  type        = string
}

variable "application_namespace" {
  description = "Kubernetes namespace for the application"
  type = string
}