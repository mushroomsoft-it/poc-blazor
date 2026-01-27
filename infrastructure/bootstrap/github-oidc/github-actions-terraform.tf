resource "aws_iam_role" "github_terraform_role" {
  depends_on = [aws_iam_openid_connect_provider.github]

  name = "GitHub-Actions-Terraform-Role"

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
          "token.actions.githubusercontent.com:sub" = "repo:sfalconi2001/poc-telemetry-managed:*"
        }
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "github_terraform_policy" {
  name        = "GitHub-Terraform-Policy"
  description = "Terraform permissions for PoC infra (EKS, VPC, backend, destroy allowed)"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # Terraform backend (S3)
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::tf-state-poc-telemetry",
          "arn:aws:s3:::tf-state-poc-telemetry/*"
        ]
      },

      # Terraform locking (DynamoDB)
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:UpdateItem",
          "dynamodb:DescribeTable"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:422600867425:table/terraform-locks"
      },

      # VPC / Networking
      {
        Effect   = "Allow"
        Action   = ["ec2:*"]
        Resource = "*"
      },

      # EKS
      {
        Effect   = "Allow"
        Action   = ["eks:*"]
        Resource = "*"
      },

      # IAM (ahora con permisos completos para Terraform)
      {
        Effect = "Allow"
        Action = [
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:GetRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:GetPolicy",
          "iam:ListPolicyVersions",
          "iam:CreateOpenIDConnectProvider",
          "iam:DeleteOpenIDConnectProvider",
          "iam:GetOpenIDConnectProvider",
          "iam:TagRole",
          "iam:UntagRole",
          "iam:ListRolePolicies",
          "iam:GetRolePolicy",
          "iam:ListAttachedRolePolicies",
          "iam:GetPolicyVersion",
          "iam:CreatePolicyVersion",
          "iam:DeletePolicyVersion",
          "iam:UpdateAssumeRolePolicy"
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = "iam:PassRole"
        Resource = [
          "arn:aws:iam::422600867425:role/*eks-node*",
          "arn:aws:iam::422600867425:role/*eks-cluster*"
        ]
      },

      # KMS (ahora con permisos completos para Terraform)
      {
        Effect = "Allow"
        Action = [
          "kms:DescribeKey",
          "kms:ListAliases",
          "kms:GetKeyPolicy",
          "kms:GetKeyRotationStatus",
          "kms:ListResourceTags"
        ]
        Resource = "arn:aws:kms:us-east-1:422600867425:key/*"
      },

      # ALB / Logs
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:DeleteLoadBalancer",
          "elasticloadbalancing:Describe*",
          "logs:CreateLogGroup",
          "logs:DeleteLogGroup",
          "logs:DescribeLogGroups"
        ]
        Resource = "*"
      },

      # General
      {
        Effect   = "Allow"
        Action   = "sts:GetCallerIdentity"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_terraform_attach" {
  role       = aws_iam_role.github_terraform_role.name
  policy_arn = aws_iam_policy.github_terraform_policy.arn
}
