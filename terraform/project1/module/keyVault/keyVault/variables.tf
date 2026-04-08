variable "key_vault_name" {
  type        = string
  description = "Name of the key vault"
}
variable "rg_name" {
  type        = string
  description = "The name of the Azure Resource Group where the keyvault will be created."
}
variable "location" {
  type        = string
  description = "The location (region) where the Azure keyvault will be created."
}
variable "kv_enabled_for_disk_encryption" {
  type        = bool
  default     = false
  description = "Specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault"
}
variable "kv_soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "The number of days that items should be retained for once soft-deleted."
}
variable "kv_purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Is Purge Protection enabled for this Key Vault"
}
variable "kv_sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault"
}
variable "kv_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure keyvault"
}
variable "public_network_access_enabled" {
  type        = bool
  description = "Public network access is allowed for this Key Vault."
}
variable "enable_rbac_authorization" {
  type        = bool
  default     = true
  description = "Enable RBAC authorization for key vault"
}
variable "enabled_for_deployment" {
  type        = bool
  default     = false
  description = "Enabled for deployment"
}
variable "enabled_for_template_deployment" {
  type        = bool
  default     = false
  description = "Enabled for template deployment"
}
variable "network_acls" {
  description = "Network rules configuration for the storage account."
  type        = any
  default = {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = []
  }
}