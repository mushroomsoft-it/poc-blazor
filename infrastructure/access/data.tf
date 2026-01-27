data "aws_caller_identity" "current" {}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "tf-state-poc-telemetry"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "github_oidc" {
  backend = "s3"
  config = {
    bucket = "tf-state-poc-telemetry"
    key    = "bootstrap/github-oidc/terraform.tfstate"
    region = "us-east-1"
  }
}
