locals {
  oidc_thumbprint = "9e99a48a9960b14926bb7f3b02e22da0afd1e6af"
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [local.oidc_thumbprint]
}
