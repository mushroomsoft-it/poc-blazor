resource "aws_eks_access_entry" "terraform_access" {
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = aws_iam_role.terraform_role.arn
  type          = "STANDARD"
}

resource "aws_eks_access_entry" "cli_user_entry" {
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.cli_user_name}"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "cli_user_admin" {
  depends_on    = [aws_eks_access_entry.cli_user_entry]
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.cli_user_name}"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
