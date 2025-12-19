resource "aws_iam_user" "observability" {
  name = "${var.project_name}-observability"
}

resource "aws_iam_policy" "observability_s3" {
  name = "${var.project_name}-observability-s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ]
      Resource = [
        aws_s3_bucket.observability.arn,
        "${aws_s3_bucket.observability.arn}/*"
      ]
    }]
  })
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.observability.name
  policy_arn = aws_iam_policy.observability_s3.arn
}

resource "aws_iam_access_key" "observability" {
  user = aws_iam_user.observability.name
}
