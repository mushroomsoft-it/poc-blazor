resource "helm_release" "aws_load_balancer_controller" {
  depends_on = [
    kubernetes_service_account_v1.alb_controller_sa
  ]

  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.7.2"

  set = [
    { name = "clusterName", value = aws_eks_cluster.eks_cluster.name },
    { name = "serviceAccount.create", value = "false" },
    { name = "serviceAccount.name", value = "aws-load-balancer-controller" },
    { name = "region", value = var.aws_region },
    { name = "vpcId", value = aws_vpc.eks_vpc.id }
  ]
}
