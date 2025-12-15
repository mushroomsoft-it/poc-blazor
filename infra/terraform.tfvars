project_name = "poc-blazor"

vpc_cidr = "10.0.0.0/16"

public_subnets = [
  {
    cidr = "10.0.1.0/24"
    az   = "us-east-1a"
    name = "eks-public-a"
  },
  {
    cidr = "10.0.2.0/24"
    az   = "us-east-1b"
    name = "eks-public-b"
  }
]

environment = "development"

cluster_name = "poc-blazor-eks-cluster"
