project_name = "poc-blazor"
environment  = "development"
aws_region   = "us-east-1"

cluster_name = "poc-blazor-eks-cluster"

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

email = "sfalconi@mushroomsoft-it.com"

cli_user_name = "sfalconi"

cli_user_name_2 = "caronate"

repository_owner = "mushroomsoft-it"

application_namespace = "poc-blazor"

repository_name = "poc-blazor"

subdomain_name = "dev.n8nmushroomsoft-it.com"

tags = {
  Project     = "poc-blazor"
  Environment = "development"
}