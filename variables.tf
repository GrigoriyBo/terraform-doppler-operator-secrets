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
    format                   = optional(string, "json")
  }))
}
variable "resync_seconds" {
  description = "The interval in seconds for resynchronizing secrets from Doppler"
  type        = number
  default     = 120
}

