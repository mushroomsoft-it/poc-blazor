data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../eks/terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}

