# variables.tf
# Variable definitions for Key Vault Objects workload supporting multiple Key Vaults

variable "kv_objects" {
  description = "A comprehensive map containing multiple Key Vault configurations with their names, resource groups, and associated objects including keys, secrets, and certificates for bulk management operations."
  type = map(object({
    kv_name    = string // Name of the Key Vault
    kv_rg_name = string // Resource group of the Key Vault

    key_definitions = map(object({                            // Definitions for each key to be created
      key_opts                             = list(string)     // Key options (e.g., "decrypt", "encrypt")
      key_type                             = string           // Type of the key (e.g., RSA)
      key_size                             = number           // Size of the key in bits
      available_rotation_policy            = bool             // Whether to enable key rotation policy
      rotation_policy_time_before_expiry   = optional(string) // Time before expiry to rotate the key
      rotation_policy_expire_after         = optional(string) // Duration after which key expires
      rotation_policy_notify_before_expiry = optional(string) // Time before expiry to send notifications
    }))

    secret_definitions = map(object({ // Definitions for secrets to be created
      secret_value = string           // Value of the secret
    }))

    certificate_name     = optional(string) // Name of the certificate (if any)
    certificate_content  = optional(string) // Certificate content in base64 or PFX format
    certificate_password = optional(string) // Password for the certificate (if protected)
  }))
  default = {} // Default is an empty map
}
