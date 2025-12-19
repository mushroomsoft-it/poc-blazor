output "aws_access_key_id" {
  value     = aws_iam_access_key.observability.id
  sensitive = true
}

output "aws_secret_access_key" {
  value     = aws_iam_access_key.observability.secret
  sensitive = true
}

output "s3_bucket_name" {
  value = aws_s3_bucket.observability.bucket
}
