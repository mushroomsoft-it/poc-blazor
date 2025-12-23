resource "kubernetes_secret_v1" "godaddy_api" {
  provider = kubernetes.eks
  metadata {
    name      = "godaddy-api-key"
    namespace = "cert-manager"
  }

  data = {
    token = "${var.godaddy_api_key}:${var.godaddy_api_secret}"
  }

  type = "Opaque"

  depends_on = [
    helm_release.cert_manager
  ]
}

resource "helm_release" "godaddy_webhook" {
  name      = "godaddy-webhook"
  namespace = "cert-manager"

  repository = "https://snowdrop.github.io/godaddy-webhook"
  chart      = "godaddy-webhook"
  version    = "0.5.0"

  set = [
    { name = "groupName", value = "acme.mycompany.com" }
  ]

  depends_on = [
    helm_release.cert_manager,
    kubernetes_secret_v1.godaddy_api
  ]
}
