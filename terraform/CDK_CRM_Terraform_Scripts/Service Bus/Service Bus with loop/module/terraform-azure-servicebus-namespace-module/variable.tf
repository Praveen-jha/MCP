#variables.tf
# Defines all input variables for creating an Azure Service Bus Namespace with optional identity, CMK, and network rules.

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the resource."
  type        = string
}

variable "servicebus_name" {
  description = "Name of the Service Bus Namespace."
  type        = string

  validation {
    condition     = length(var.servicebus_name) >= 6 && length(var.servicebus_name) <= 50
    error_message = "Service Bus name must be between 6 and 50 characters."
  }
}

variable "sku" {
  description = "SKU for the Service Bus Namespace (Basic, Standard, Premium)."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be one of: Basic, Standard, Premium."
  }
}

variable "capacity" {
  description = "Messaging units for Premium SKU or partition count for Standard."
  type        = number

  validation {
    condition     = var.capacity >= 0 && var.capacity <= 16
    error_message = "Capacity must be between 0 and 16."
  }
}

variable "premium_messaging_partitions" {
  description = "Number of messaging partitions for Premium SKU."
  type        = number
  default     = null

  validation {
    condition     = var.premium_messaging_partitions == null || (var.premium_messaging_partitions >= 1 && var.premium_messaging_partitions <= 4)
    error_message = "If provided, premium_messaging_partitions must be between 1 and 4."
  }
}

variable "local_auth_enabled" {
  description = "Whether local authentication is enabled."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
}

variable "minimum_tls_version" {
  description = "The minimum TLS version to support."
  type        = string
  default     = "1.2"

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "minimum_tls_version must be one of: 1.0, 1.1, 1.2."
  }
}

variable "tags" {
  description = "Tags for the resource."
  type        = map(string)
  default     = {}
}

variable "identity" {
  description = "Identity block."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "customer_managed_key" {
  description = "CMK block."
  type = object({
    key_vault_key_id                  = string
    identity_id                       = string
    infrastructure_encryption_enabled = optional(bool)
  })
  default = null
}

variable "network_rule_set" {
  description = "Network rules."
  type = object({
    default_action                = string
    public_network_access_enabled = optional(bool)
    trusted_services_allowed      = optional(bool)
    ip_rules                      = optional(list(string))
    network_rules = optional(list(object({
      subnet_id                          = string
      ignore_missing_vnet_service_endpoint = optional(bool)
    })))
  })
  default = null
}