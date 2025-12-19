output "eks_cluster_name" {
  description = "EKS Cluster name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "alb_controller_role_arn" {
  description = "ARN of the IAM Role for AWS Load Balancer Controller"
  value       = aws_iam_role.alb_controller.arn
}

output "github_deploy_role_arn" {
  description = "ARN of the GitHub deploy role"
  value       = aws_iam_role.github_deploy_role.arn
}

output "vpc_id" {
  description = "VPC used by the EKS cluster"
  value       = aws_vpc.eks_vpc.id
}

output "region" {
  description = "AWS Region"
  value       = var.aws_region
}

output "terraform_role_arn" {
  value = aws_iam_role.terraform_role.arn
}

output "current_account_id" {
  value = data.aws_caller_identity.current.account_id
}

