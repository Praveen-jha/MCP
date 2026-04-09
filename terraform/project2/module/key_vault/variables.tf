# General Key Vault Variables
variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

variable "location" {
  description = "The location/region where the Key Vault will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault."
  type        = string
}

variable "enabled_for_disk_encryption" {
  description = "Whether the Key Vault is enabled for disk encryption."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days soft deleted items should be retained."
  type        = number
  default     = 90
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled on the Key Vault."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Allow public network access to the Key Vault."
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "The SKU name of the Key Vault (Standard or Premium)."
  type        = string
}

variable "enable_rbac_authorization" {
  description = "Enable Role-Based Access Control (RBAC) for the Key Vault."
  type        = bool
}

# Contact Information
variable "contact_name" {
  description = "The name of the contact person for the Key Vault."
  type        = string
  default     = ""
}

variable "contact_email" {
  description = "The email of the contact person for the Key Vault."
  type        = string
  default     = ""
}

# Tags
variable "tags" {
  description = "A map of tags to assign to the Key Vault."
  type        = map(string)
  default     = {}
}

variable "key_definitions" {
  description = "Map of key names and their properties"
  type = map(object({
    key_opts                             = list(string)
    key_type                             = string
    key_size                             = number
    available_rotation_policy            = bool
    rotation_policy_time_before_expiry   = optional(string)
    rotation_policy_expire_after         = optional(string)
    rotation_policy_notify_before_expiry = optional(string)
  }))
}

variable "secret_definitions" {
  description = "Map of secret names and their values"
  type = map(object({
    secret_value = string
  }))
}

variable "content_type" {
  description = "Content Type of the secret"
  type        = string
  default     = "text/plain"
}

variable "network_rules_ip_rules" {
  description = "List of allowed IPs for accessing the storage account"
  type        = list(string)
  default     = []
}

variable "network_rules_virtual_network_subnet_ids" {
  description = "List of subnet IDs that are allowed to access the storage account"
  type        = list(string)
  default     = []
}
