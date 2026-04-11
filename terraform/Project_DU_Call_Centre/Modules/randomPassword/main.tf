resource "random_password" "password" {
  length  = var.password_length
  special = true
  lower   = true
  numeric = true
  upper   = true
}

resource "azurerm_key_vault_secret" "password_secret" {
  name         = var.secret_name
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
}
