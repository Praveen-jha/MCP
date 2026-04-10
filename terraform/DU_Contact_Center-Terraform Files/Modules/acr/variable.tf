variable "container_registry_name" {
  description = "Specifies the name of the Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location"
  type        = string
}

variable "sku" {
  description = "The SKU name of the container registry"
  type        = string
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be one of: Basic, Standard, Premium."
  }
}

variable "admin_enabled" {
  description = "Enable the admin user"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Allow public network access"
  type        = bool
  default     = true
}

variable "quarantine_policy_enabled" {
  description = "Enable quarantine policy"
  type        = bool
  default     = false
}

variable "retention_policy_in_days" {
  description = "Retention policy duration in days"
  type        = number
  default     = null
}

variable "trust_policy_enabled" {
  description = "Enable trust policy"
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Enable zone redundancy"
  type        = bool
  default     = false
}

variable "export_policy_enabled" {
  description = "Enable export policy"
  type        = bool
  default     = true
}

variable "anonymous_pull_enabled" {
  description = "Enable anonymous pull access"
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Enable dedicated data endpoints"
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "Trusted Azure services bypass option"
  type        = string
  default     = "AzureServices"
}

variable "identity" {
  description = "Managed identity block"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "encryption" {
  description = "Encryption configuration block"
  type = object({
    key_vault_key_id   = string
    identity_client_id = string
  })
  default = null
}

variable "georeplications" {
  description = "List of georeplication configurations"
  type = list(object({
    location                  = string
    regional_endpoint_enabled = optional(bool)
    zone_redundancy_enabled   = optional(bool)
    tags                      = optional(map(string))
  }))
  default = []
}

variable "network_rule_set" {
  description = "Network rule set"
  type = object({
    default_action = string
    ip_rule = optional(list(object({
      action   = string
      ip_range = string
    })))
  })
  default = null
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
