variable "configurations" {
  description = "The list of configurations for creating Doppler secrets and DopplerSecret resources"
  type = map(object({
    doppler_secret_name      = string
    doppler_secret_namespace = string
    token_secret_name        = string
    doppler_api_token        = string
    managed_secret_name      = string
    managed_secret_namespace = string
    managed_secret_type      = string
  }))
}
variable "resync_seconds" {
  description = "The interval in seconds for resynchronizing secrets from Doppler"
  type        = number
  default     = 120
}

variable "format" {
  type        = string
  default     = null
  description = <<EOT
The format in which secrets should be synchronized. Instead of the standard Key/Value pairs, you can download secrets as a single file in the following formats:

- json
- dotnet-json
- env
- yaml
- docker

If not specified, the default format will be used.
EOT
}
