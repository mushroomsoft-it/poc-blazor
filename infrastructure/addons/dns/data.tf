data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../../eks/terraform.tfstate"
  }
}

data "terraform_remote_state" "access" {
  backend = "local"

  config = {
    path = "../../access/terraform.tfstate"
  }
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../../network/terraform.tfstate"
  }
}


data "aws_caller_identity" "current" {}

