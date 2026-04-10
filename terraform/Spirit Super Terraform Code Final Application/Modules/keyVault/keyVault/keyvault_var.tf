variable "keyVaultName" {
  type = string
  description = "Name of the key vault"
}

variable "rgName" {
  type        = string
  description = "The name of the Azure Resource Group where the keyvault will be created."
}

variable "location" {
  type        = string
  description = "The location (region) where the Azure keyvault will be created."
}

variable "kvEnabledForDiskEncryption" {
  type        = bool
  description = "specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault"
}

variable "kvSoftDeleteRetentionDays" {
  type        = number
  description = "The number of days that items should be retained for once soft-deleted."
}

variable "kvPurgeProtectionEnabled" {
  type        = bool
  description = "Is Purge Protection enabled for this Key Vault"
}

variable "kvSkuName" {
  type        = string
  description = "The Name of the SKU used for this Key Vault"
}

variable "kvTags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure keyvault"
}

variable "publicNetworkAccessEnabled" {
  type        = bool
  description = "public network access is allowed for this Key Vault."
}

variable "enableRbacAuthorization" {
  type = string
  description = "enable rbac authorization for key vault"
}

variable "enabledForDeployment" {
  type = string
  description = "enabled for deployment"
}

variable "enabledForTemplateDeployment" {
  type = string
  description = "enabled for template deployment"
}

variable "kvIpRules" {
  type = list(string)
  description = "ip rules for key vault stores list of ip address to be whitelisted"
}

variable "bypass" {
  type = string
  description = "bypass to which services"
}

variable "defaultAction" {
  type = string
  description = "default action for network acl of keyvault"
}
