variable "storage_account_id" {
  type        = string
  description = "The ID of the Azure Storage Account to associate with the customer-managed key."
}
 
variable "key_vault_id" {
  type        = string
  description = "The ID of the Azure Key Vault containing the encryption key."
}
 
variable "key_name" {
  type        = string
  description = "The name of the key in the Azure Key Vault to be used for encryption."
}
 
variable "user_assigned_identity_clientid" {
  type        = string
  description = "The client ID of the user-assigned managed identity. This is required to authenticate resources that use this identity."
}
 
variable "user_assigned_identity_id" {
  type        = string
  description = "A list of IDs for the user-assigned managed identities associated with the resource. Required if 'identity_type' is set to 'UserAssigned'."
}