variable "aws_region" {
  description = "AWS region used"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-demo-cluster"
}

variable "terraform_user_arn" {
  description = "ARN of the user or role that Terraform will use to manage the EKS cluster"
  type        = string
}
variable "github_deploy_role_arn" {
  description = "ARN of the GitHub Actions deploy role"
  type        = string
}

