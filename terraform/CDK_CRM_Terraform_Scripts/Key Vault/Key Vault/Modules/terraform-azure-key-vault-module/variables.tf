# variables.tf
# Description: Declaring the variables required for creating Key vault.

# General Key Vault Variables
variable "key_vault_name" {
  description = "Specifies the name of the Azure Key Vault to be created, which must be unique within the Azure region."
  type        = string

  validation {
    condition     = length(var.key_vault_name) >= 3 && length(var.key_vault_name) <= 24
    error_message = "Key Vault name must be between 3 and 24 characters long."
  }
}

variable "tenant_id" {
  type        = string
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. "
}

variable "location" {
  description = "Specifies the Azure region where the Key Vault will be provisioned."
  type        = string

  validation {
    condition     = length(var.location) > 0
    error_message = "Location cannot be empty."
  }
}

variable "resource_group_name" {
  description = "Specifies the name of the Azure Resource Group in which the Key Vault will be created."
  type        = string

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "Resource group name cannot be empty."
  }
}

variable "enabled_for_disk_encryption" {
  description = "Determines whether the Key Vault is enabled to support disk encryption operations for Azure VMs."
  type        = bool
  default     = false
}

variable "enabled_for_deployment" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  default     = null
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default     = null
}

variable "soft_delete_retention_days" {
  description = "Sets the number of days that soft-deleted Key Vault objects are retained before permanent deletion."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "Soft delete retention days must be between 7 and 90 days."
  }
}

variable "purge_protection_enabled" {
  description = "Specifies whether purge protection is enabled to prevent the permanent deletion of Key Vault and its contents."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Determines whether public network access is allowed to the Key Vault from the internet."
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "Specifies the pricing tier of the Key Vault, either 'standard' or 'premium', to determine supported features."
  type        = string

  validation {
    condition     = contains(["standard", "premium"], lower(var.sku_name))
    error_message = "SKU name must be either 'standard' or 'premium' (case insensitive)."
  }
}

variable "enable_rbac_authorization" {
  description = "Enables Role-Based Access Control (RBAC) instead of traditional access policies for managing Key Vault permissions."
  type        = bool
}

# Tags
variable "tags" {
  description = "Defines a map of key-value pairs used to tag the Key Vault resource for identification and cost management."
  type        = map(string)
  default     = {}
}

variable "create_kv" {
  description = "Indicates whether a new Key Vault should be created as part of this deployment."
  type        = bool
  default     = true
  nullable    = true
}

variable "network_acls" {
  description = "Network rules configuration for the storage account."
  type = object({
    default_action             = string      //Specifies the default network access action for the Key Vault, either 'Allow' or 'Deny', for public network requests.
    bypass                     = string      //Specifies which trusted Microsoft services can bypass the Key Vault firewall, either 'AzureServices' or 'None'.
    ip_rules                   = set(string) //Provides a list of IP addresses or CIDR blocks that are allowed to access the Key Vault.
    virtual_network_subnet_ids = set(string) //Provides a list of Azure subnet resource IDs that are permitted to access the Key Vault.
  })
  default = null
}

variable "key_vault_access_policies" {
  description = "A list of access policies for the Key Vault, used when enable_rbac_authorization is false."
  type = list(object({
    object_id               = string                     # The Azure AD Object ID (User, Group, or Service Principal)
    tenant_id               = string                     # The Azure AD Tenant ID of the object
    key_permissions         = optional(list(string), []) # List of key permissions
    secret_permissions      = optional(list(string), []) # List of secret permissions
    certificate_permissions = optional(list(string), []) # List of certificate permissions
    storage_permissions     = optional(list(string), []) # List of storage permissions
  }))
  default = [] # Default to an empty list
}

variable "key_vault_roles" {
  type        = set(string)
  description = "List of Key Vault Roles to be assigned."
  default     = []
}

variable "principal_id" {
  type        = string
  description = " (Required) The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to."
  default     = null
}
