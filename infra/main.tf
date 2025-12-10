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

data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.demo_cluster.name
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.demo_cluster.name
}

data "aws_eks_cluster" "cluster_waiter" {
  name = aws_eks_cluster.demo_cluster.name

  depends_on = [
    aws_eks_access_policy_association.terraform_admin
  ]
}

resource "null_resource" "wait_for_access" {
  depends_on = [
    aws_eks_access_policy_association.terraform_admin
  ]
}

resource "time_sleep" "wait_access" {
  depends_on      = [aws_eks_access_policy_association.terraform_admin]
  create_duration = "30s"
}

provider "kubernetes" {
  alias = "eks"

  host                   = data.aws_eks_cluster.cluster_waiter.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_waiter.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.cluster_waiter.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_waiter.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
