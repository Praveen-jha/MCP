# Variable definitions for Key Vault Objects workload

# Name of the existing or to‑be‑created Key Vault
variable "key_vault_name" {
  description = "The name identifier for the Azure Key Vault resource that will be used to store and manage cryptographic keys, secrets, and certificates securely."
  type        = string
}

# Resource group that contains (or will contain) the Key Vault
variable "key_vault_rg_name" {
  description = "The name of the Azure Resource Group that contains or will contain the Key Vault resource for proper organization and management of related Azure resources."
  type        = string
}

variable "key_definitions" {
  description = "A comprehensive map containing cryptographic key names as keys and their detailed configuration properties including encryption options, key types, sizes, and automated rotation policies for secure key management operations."
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
  description = "A map containing secret names as keys and their corresponding sensitive values that will be securely encrypted and stored in the Azure Key Vault for application configuration and credential management."
  type = map(object({
    secret_value = string
  }))
  default = {}
}

variable "certificate_name" {
  description = "The unique name identifier for the SSL/TLS certificate that will be imported and stored in the Azure Key Vault for secure authentication and encryption purposes."
  type        = string
  default     = null
}

variable "certificate_content" {
  description = "The file path location or base64-encoded content of the certificate file in PFX format that contains the certificate data to be imported into the Key Vault."
  type        = string
  default     = null
}

variable "certificate_password" {
  description = "The password required to decrypt and access the PFX certificate file during the import process, marked as sensitive to prevent exposure in logs and state files."
  type        = string
  default     = null
  sensitive   = true
}