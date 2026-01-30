variable "aws_region" {
  description = "AWS region used"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, stage, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name (used only for subnet tags)"
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
