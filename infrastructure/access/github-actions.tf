resource "aws_iam_role" "github_deploy_role" {
  depends_on = [aws_iam_openid_connect_provider.github]

  name = "GitHub-Actions-Deploy-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:mushroomsoft-it/poc-blazor:*"
        }
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "github_deploy_policy" {
  name        = "GitHubActions-EKS-Deploy-Policy"
  description = "Minimal permissions for GitHub Actions to deploy to EKS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:GetCallerIdentity"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "eks:AccessKubernetesApi"
        ]
        Resource = data.terraform_remote_state.eks.outputs.cluster_arn
      },
      {
        Effect = "Allow"
        Action = [
          "eks:ListClusters"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole"
        ]
        Resource = [
          data.terraform_remote_state.eks.outputs.eks_node_role_arn,
          data.terraform_remote_state.eks.outputs.eks_cluster_role_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_deploy_custom_policy" {
  role       = aws_iam_role.github_deploy_role.name
  policy_arn = aws_iam_policy.github_deploy_policy.arn
}
