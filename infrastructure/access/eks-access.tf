resource "aws_eks_access_entry" "terraform_access" {
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = aws_iam_role.terraform_role.arn
  type          = "STANDARD"
}

resource "aws_eks_access_entry" "cli_user_entry" {
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = "arn:aws:iam::422600867425:user/cli-user"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "cli_user_admin" {
  depends_on    = [aws_eks_access_entry.cli_user_entry]
  cluster_name  = data.terraform_remote_state.eks.outputs.cluster_name
  principal_arn = "arn:aws:iam::422600867425:user/cli-user"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
