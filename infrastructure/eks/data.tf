data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "tf-state-poc-telemetry"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
