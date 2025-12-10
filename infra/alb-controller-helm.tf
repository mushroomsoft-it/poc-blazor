resource "helm_release" "aws_load_balancer_controller" {
  depends_on = [
    kubernetes_service_account_v1.alb_controller_sa,
    aws_iam_role_policy_attachment.alb_attach_policy

  ]

  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.16.0"

  set = [
    { name = "clusterName", value = aws_eks_cluster.demo_cluster.name },
    { name = "serviceAccount.create", value = "false" },
    { name = "serviceAccount.name", value = "aws-load-balancer-controller" },
    { name = "region", value = var.aws_region },
    { name = "vpcId", value = aws_vpc.eks_vpc.id }
  ]
}
