variable "account_name" {
  description = "The name of the Cognitive Account"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "kind" {
  description = "The kind of Cognitive Account"
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the Cognitive Account"
  type        = string
}

variable "local_auth_enabled" {
  description = "Whether local authentication is enabled"
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled"
  type        = bool
}

variable "identity_type" {
  description = "The type of managed identity"
  type        = string
}

variable "identity_ids" {
  description = "The list of identity IDs"
  type        = list(string)
}

variable "key_vault_key_id" {
  description = "The key vault key ID for customer managed key"
  type        = string

}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "custom_subdomain_name" {
  type        = string
  description = "A custom subdomain name for the endpoint of the Azure resource."
}