# This resource creates a secret in Azure Key Vault with the specified name and value, associating it with the provided Key Vault.
resource "azurerm_key_vault_secret" "kv_secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = var.key_vault_id
}