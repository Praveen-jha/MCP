output "keyvault" {
  description = "Output: Key Vault."
  value       = azurerm_key_vault.keyvault
}

output "key_vault_id" {
  value       = azurerm_key_vault.keyvault.id
  description = "The ID of the Key Vault."
}
