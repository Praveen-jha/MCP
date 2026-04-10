resource "azurerm_cognitive_account_customer_managed_key" "cmk" {
  cognitive_account_id = var.cognitive_account_id
  key_vault_key_id     = var.key_vault_key_id
  identity_client_id   = var.user_assigned_identity_clientid
}