# variables.tf
# Description: Declaring the variables required for creating Key vault Objects.

variable "certificate_name" {
  type        = string
  description = "The name identifier for the certificate that will be stored in the Azure Key Vault for SSL/TLS authentication purposes"
  default     = null
}

variable "certificate_content" {
  type        = string
  description = "The base64-encoded certificate content or PFX file content that contains the certificate data to be imported into the Key Vault"
  default     = null
}

variable "certificate_password" {
  type        = string
  description = "The password required to decrypt and access the certificate content if the certificate is password-protected or in PFX format"
  default     = null
  sensitive   = true
}

variable "kv_id" {
  description = "The unique resource identifier of the existing Azure Key Vault where the certificates, keys, and secrets will be stored and managed"
  type        = string
}

variable "key_definitions" {
  description = "A map containing key names as keys and their corresponding configuration properties including encryption options, key type, size, and rotation policies for cryptographic operations"
  type = map(object({
    key_opts                             = list(string)
    key_type                             = string
    key_size                             = number
    available_rotation_policy            = bool
    rotation_policy_time_before_expiry   = optional(string)
    rotation_policy_expire_after         = optional(string)
    rotation_policy_notify_before_expiry = optional(string)
  }))
  default = {}
}

variable "secret_definitions" {
  description = "A map containing secret names as keys and their corresponding secret values that will be securely stored in the Azure Key Vault for application configuration and sensitive data management"
  type = map(object({
    secret_value = string
  }))
  default = {}
}
