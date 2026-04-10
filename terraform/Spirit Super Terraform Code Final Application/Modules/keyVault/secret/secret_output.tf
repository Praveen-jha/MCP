output "kvSecretValue" {
  value = azurerm_key_vault_secret.secret.value
  description = "Value of the Key Vault Secret."
}
