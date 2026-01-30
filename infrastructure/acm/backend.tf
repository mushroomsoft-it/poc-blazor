terraform {
  backend "s3" {
    bucket         = "tf-state-poc-telemetry"
    key            = "acm/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
