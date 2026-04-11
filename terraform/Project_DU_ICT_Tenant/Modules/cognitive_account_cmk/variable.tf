variable "key_vault_key_id" {
  type        = string
  description = "The resource ID of the Azure Key Vault to be used. This may be used for storing secrets or keys for secure access."
}

variable "user_assigned_identity_clientid" {
  type        = string
  description = "The client ID of the user-assigned managed identity. This is required to authenticate resources that use this identity."
}

variable "cognitive_account_id" {
  type = string
  description = "The resource ID of cognitive account"
}