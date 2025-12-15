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
  default = "1.29"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}
