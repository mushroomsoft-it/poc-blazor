data "aws_caller_identity" "current" {}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "tf-state-poc-telemetry"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "access" {
  backend = "s3"

  config = {
    bucket = "tf-state-poc-telemetry"
    key    = "access/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "tf-state-poc-telemetry"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}





