variable "aws_region" {
  description = "AWS region used"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for EKS VPC"
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

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.30"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

variable "email" {
  type        = string
  description = "Email address for Let's Encrypt notifications"
}

variable "godaddy_api_key" {
  type        = string
  description = "GoDaddy API key for DNS management"
}

variable "godaddy_api_secret" {
  type        = string
  description = "GoDaddy API secret for DNS management"
}
