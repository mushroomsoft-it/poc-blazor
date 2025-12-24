# resource "kubernetes_manifest" "letsencrypt_godaddy" {
#   provider = kubernetes.eks
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "ClusterIssuer"
#     metadata = {
#       name = "letsencrypt-godaddy"
#     }
#     spec = {
#       acme = {
#         email  = var.email
#         server = "https://acme-v02.api.letsencrypt.org/directory"

#         privateKeySecretRef = {
#           name = "letsencrypt-godaddy-account-key"
#         }

#         solvers = [{
#           dns01 = {
#             webhook = {
#               groupName  = "acme.mycompany.com"
#               solverName = "godaddy"
#               config = {
#                 apiKeySecretRef = {
#                   name = "godaddy-api-key"
#                   key  = "token"
#                 }
#                 production = true
#                 ttl        = 600
#               }
#             }
#           }
#         }]
#       }
#     }
#   }

#   depends_on = [
#     helm_release.cert_manager,
#     helm_release.godaddy_webhook,
#     kubernetes_secret_v1.godaddy_api
#   ]
# }
