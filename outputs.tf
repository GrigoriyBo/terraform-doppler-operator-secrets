output "doppler_secret_names" {
  description = "Names of the created DopplerSecret resources"
  value = { for k, v in kubernetes_manifest.doppler_secret : k => v.manifest["metadata"]["name"] }
}

output "token_secret_names" {
  description = "Names of the created Kubernetes token secrets"
  value = { for k, v in kubernetes_secret.doppler_token_secret : k => v.metadata[0].name }
}

output "doppler_secret_namespaces" {
  description = "Namespaces of the created DopplerSecret resources"
  value = { for k, v in kubernetes_manifest.doppler_secret : k => v.manifest["metadata"]["namespace"] }
}

output "token_secret_namespaces" {
  description = "Namespaces of the created token secrets"
  value = { for k, v in kubernetes_secret.doppler_token_secret : k => v.metadata[0].namespace }
}