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

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled"
  type        = bool
}

variable "custom_subdomain_name" {
  type        = string
  description = "A custom subdomain name for the endpoint of the Azure resource."
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of managed identity to be used. Possible values include 'SystemAssigned', 'UserAssigned', or 'None'."
}

variable "user_assigned_identity_id" {
  type        = list(string)
  description = "A list of IDs for the user-assigned managed identities associated with the resource. Required if 'identity_type' is set to 'UserAssigned'."
}

variable "key_vault_key_id" {
  type        = string
  description = "The resource ID of the Azure Key Vault to be used. This may be used for storing secrets or keys for secure access."
}

variable "user_assigned_identity_clientid" {
  type        = string
  description = "The client ID of the user-assigned managed identity. This is required to authenticate resources that use this identity."
}
