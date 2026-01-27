resource "aws_iam_role" "github_deploy_role" {
  name = "GitHub-Actions-Deploy-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = data.terraform_remote_state.github_oidc.outputs.github_oidc_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:sfalconi2001/poc-telemetry-managed:*"
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
  description = "Minimal permissions for GitHub Actions to deploy to EKS (API auth mode)"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:GetCallerIdentity",
          "eks:DescribeCluster",
          "eks:AccessKubernetesApi"
        ]
        Resource = "arn:aws:eks:us-east-1:422600867425:cluster/poc-blazor-eks-cluster"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_deploy_policy_attachment" {
  role       = aws_iam_role.github_deploy_role.name
  policy_arn = aws_iam_policy.github_deploy_policy.arn
}

resource "aws_eks_access_entry" "github" {
  cluster_name  = "poc-blazor-eks-cluster"
  principal_arn = aws_iam_role.github_deploy_role.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_edit" {
  cluster_name  = "poc-blazor-eks-cluster"
  principal_arn = aws_iam_role.github_deploy_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"

  access_scope {
    type       = "namespace"
    namespaces = ["dotnet9-app"]
  }
}
