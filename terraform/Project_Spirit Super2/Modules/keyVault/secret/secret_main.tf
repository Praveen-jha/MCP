resource "azurerm_key_vault_secret" "secret" {
  name         = var.secretName
  value        = var.secretValue
  key_vault_id = var.kvId 
}

