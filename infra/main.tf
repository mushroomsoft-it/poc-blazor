terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.24.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.30.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "time_sleep" "wait_access" {
  depends_on      = [aws_eks_access_policy_association.terraform_admin]
  create_duration = "30s"
}

provider "kubernetes" {
  alias = "eks"

  host = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(
    aws_eks_cluster.eks_cluster.certificate_authority[0].data
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      aws_eks_cluster.eks_cluster.name,
      "--role-arn",
      aws_iam_role.terraform_role.arn
    ]
  }
}

provider "helm" {
  kubernetes = {
    host = aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(
      aws_eks_cluster.eks_cluster.certificate_authority[0].data
    )

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        aws_eks_cluster.eks_cluster.name,
        "--role-arn",
        aws_iam_role.terraform_role.arn
      ]
    }
  }
}
