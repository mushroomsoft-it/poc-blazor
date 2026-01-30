output "github_role_arn" {
  value = aws_iam_role.github_deploy_role.arn
}

output "terraform_role_arn" {
  value = aws_iam_role.terraform_role.arn
}
