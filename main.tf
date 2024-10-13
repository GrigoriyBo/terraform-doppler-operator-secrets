resource "kubernetes_secret" "doppler_token_secret" {
  for_each = var.configurations

  metadata {
    name      = each.value["token_secret_name"]
    namespace = each.value["doppler_secret_namespace"]
  }

  data = {
    serviceToken = each.value["doppler_api_token"]
  }

  type = "Opaque"
}

resource "kubernetes_manifest" "doppler_secret" {
  for_each = var.configurations

  depends_on = [kubernetes_secret.doppler_token_secret]

  manifest = {
    apiVersion = "secrets.doppler.com/v1alpha1"
    kind       = "DopplerSecret"
    metadata = {
      name      = each.value["doppler_secret_name"]
      namespace = each.value["doppler_secret_namespace"]
    }
    spec = {
      tokenSecret = {
        name = each.value["token_secret_name"]
      }
      managedSecret = {
        name      = each.value["managed_secret_name"]
        namespace = each.value["managed_secret_namespace"]
        type      = each.value["managed_secret_type"]
      }
      resyncSeconds = var.resync_seconds
      format        = lookup(each.value, "format", null)
    }
  }
}