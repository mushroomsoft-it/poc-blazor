resource "aws_s3_bucket" "observability" {
  bucket        = "${var.project_name}-observability"
  force_destroy = true
}
