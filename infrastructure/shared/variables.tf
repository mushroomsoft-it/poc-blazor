variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets configuration"
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
}

variable "email" {
  description = "Email for Let's Encrypt notifications"
  type        = string
}

variable "godaddy_api_key" {
  description = "GoDaddy API key"
  type        = string
  sensitive   = true
}

variable "godaddy_api_secret" {
  description = "GoDaddy API secret"
  type        = string
  sensitive   = true
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

variable "application_namespace" {
  description = "Kubernetes namespace for the application"
  type = string
}

variable "repository_name" {
  description = "GitHub repository name"
  type        = string
}