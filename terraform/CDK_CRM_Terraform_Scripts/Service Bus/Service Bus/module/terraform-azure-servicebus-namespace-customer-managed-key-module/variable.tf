/**
 * Input variables for azurerm_servicebus_namespace_customer_managed_key
 * Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_customer_managed_key
 */

variable "namespace_id" {
  description = "The ID of the Service Bus Namespace (must have System Assigned Identity)."
  type        = string
  validation {
    condition     = length(var.namespace_id) > 0
    error_message = "The 'namespace_id' cannot be an empty string."
  }
}

variable "key_vault_key_id" {
  description = "The ID of the Key Vault Key used for encryption."
  type        = string
  validation {
    condition     = length(var.key_vault_key_id) > 0
    error_message = "The 'key_vault_key_id' cannot be an empty string."
  }
}

variable "infrastructure_encryption_enabled" {
  description = "Flag to enable Infrastructure Encryption. Defaults to null. Changing this will recreate the resource."
  type        = bool
  default     = null
}
