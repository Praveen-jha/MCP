variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

variable "location" {
  description = "The location where the Azure Key Vault will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure Key Vault."
  type        = string
}

variable "enabled_for_disk_encryption" {
  description = "Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the key vault."
  type        = string
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft deleted."
  type        = string
}

variable "purge_protection_enabled" {
  description = "Specifies whether purge protection should be enabled for this Key Vault."
  type        = string
}

variable "public_network_access_enabled" {
  type        = bool
  description = "public network access for key vault"
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault."
  type        = string
}

variable "enable_rbac_authorization" {
  type    = bool
  default = true
  description = "A flag to enable or disable Role-Based Access Control (RBAC) authorization for the resource."
}


# variable "tags" {
#   description = "A map of tags to assign to the resource"
#   type        = map(string)
# }