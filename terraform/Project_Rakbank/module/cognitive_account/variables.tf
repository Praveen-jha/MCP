variable "name" {
  description = "name of resource"
  type        = string
}
variable "location" {
  description = "The Azure region whre resource will be deployed"
  type        = string
}
variable "rg_name" {
  description = "name of resource group"
  type        = string
}
variable "kind" {
  description = "The kind of resouce"
  type        = string
}
variable "sku_name" {
  description = "The SKU (pricing tier) for the resource"
  type        = string
}
variable "publice_network_access_enabled" {
  description = "networking of resource"
  type        = bool
  default     = false
}
variable "tags" {
  description = "tags for the resource"
  type        = map(string)
}
variable "custom_subdomain" {
  description = "The subdomain name used for token-based authentication"
  type        = string
}
variable "cognitive_identity" {
  description = "It specifies the type of Managed Service Identity that should be configured"
  type        = string
}

variable "local_auth_enabled" {
  description = "Whether local authentication methods is enabled for the Cognitive Account"
  type        = bool
}

variable "key_scope_id" {
  description = "The versionless ID of the Key Vault key for role assignment."
  type        = string
}
variable "key_vault_key_id" {
  description = "key id to encrypt the service"
  type        = string
}
