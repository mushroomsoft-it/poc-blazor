terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.24.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.38.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.1.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  alias = "eks"

  host = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(
    aws_eks_cluster.eks_cluster.certificate_authority[0].data
  )

  exec {
    api_version = "client.authentication.k8s.io/v1"
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
      api_version = "client.authentication.k8s.io/v1"
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
