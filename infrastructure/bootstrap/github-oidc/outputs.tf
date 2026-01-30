output "github_oidc_arn" {
  description = "ARN of the GitHub OIDC Provider"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "github_oidc_url" {
  description = "URL of the GitHub OIDC Provider"
  value       = aws_iam_openid_connect_provider.github.url
}
