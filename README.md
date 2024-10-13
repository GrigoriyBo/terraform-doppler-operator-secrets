
# Doppler Secrets Terraform Module

This Terraform module creates Kubernetes secrets for Doppler and manages `DopplerSecret` resources, allowing you to integrate Doppler secrets into Kubernetes. The module supports multiple environments and allows configuring synchronization intervals and output formats for secrets.

## Features

- Create Kubernetes secrets with Doppler API tokens.
- Manage DopplerSecret resources for synchronizing secrets from Doppler.
- Supports custom synchronization intervals (`resyncSeconds`).
- Supports various output formats (`json`, `yaml`, `dotnet-json`, etc.) with a default format of `json`.
- Easy to configure multiple environments via a map of configurations.

## Usage

### Example Configuration

```hcl
module "doppler_secrets" {
  source = "./doppler-secrets"

  configurations = {
    "test" = {
      doppler_secret_name      = "dopplersecret-test"
      doppler_secret_namespace = "doppler-operator-system"
      token_secret_name        = "doppler-token-secret"
      doppler_api_token        = "your-doppler-api-token"
      managed_secret_name      = "doppler-test-secret"
      managed_secret_namespace = "default"
      managed_secret_type      = "Opaque"
      format                   = "yaml"  # Optional, defaults to "json"
    },
    "prod" = {
      doppler_secret_name      = "dopplersecret-prod"
      doppler_secret_namespace = "doppler-operator-system"
      token_secret_name        = "doppler-prod-token-secret"
      doppler_api_token        = "your-prod-doppler-api-token"
      managed_secret_name      = "doppler-prod-secret"
      managed_secret_namespace = "prod"
      managed_secret_type      = "Opaque"
      # No format specified, will default to "json"
    }
  }

  resync_seconds = 300  # Optional: Override the default sync interval (120s by default)
}
```

### Inputs

| Name                 | Description                                                                                   | Type                | Default       | Required |
|----------------------|-----------------------------------------------------------------------------------------------|---------------------|---------------|----------|
| `configurations`      | A map of configurations for creating Doppler secrets and `DopplerSecret` resources.           | `map(object)`       | n/a           | Yes      |
| `resync_seconds`      | Interval in seconds for resynchronizing secrets from Doppler.                                  | `number`            | `120`         | No       |

### Configuration Object Fields

Each configuration in the `configurations` map must have the following fields:

| Name                    | Description                                                                                          | Type     | Required |
|-------------------------|------------------------------------------------------------------------------------------------------|----------|----------|
| `doppler_secret_name`    | The name of the `DopplerSecret` resource to be created.                                               | `string` | Yes      |
| `doppler_secret_namespace` | The Kubernetes namespace where the `DopplerSecret` resource will be created.                        | `string` | Yes      |
| `token_secret_name`      | The name of the Kubernetes secret that stores the Doppler API token.                                  | `string` | Yes      |
| `doppler_api_token`      | The Doppler API token for accessing secrets.                                                         | `string` | Yes      |
| `managed_secret_name`    | The name of the Kubernetes secret that will be managed by the Doppler operator.                      | `string` | Yes      |
| `managed_secret_namespace` | The Kubernetes namespace where the managed secret will be created.                                   | `string` | Yes      |
| `managed_secret_type`    | The type of the Kubernetes secret (e.g., `Opaque`).                                                   | `string` | Yes      |
| `format`                 | The format in which secrets are downloaded (`json`, `yaml`, `dotnet-json`, `env`, `docker`).          | `string` | No (defaults to `json`) |

### Outputs

The module does not provide any explicit outputs. However, it creates and manages Kubernetes secrets and `DopplerSecret` resources as part of its process.

## Requirements

- Doppler account with API token for accessing secrets.
- Kubernetes Doppler Operator installed.

## Installation

1. Install the Doppler Operator in your Kubernetes cluster. You can follow the [Doppler Operator installation guide](https://docs.doppler.com/docs/kubernetes-operator).
2. Add this Terraform module to your configuration.

## Customization

- You can adjust the synchronization interval (`resyncSeconds`) by changing the `resync_seconds` variable.
- To specify how secrets are downloaded from Doppler (e.g., in JSON, YAML, or Docker format), you can use the `format` field in the configuration map. It defaults to `json` if not specified.

## Contributing

Feel free to submit issues and pull requests if you'd like to contribute to this project.
