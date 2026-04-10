output "kvName" {
  value       = azurerm_key_vault.keyvault.name
  description = "The name of the Key Vault."
}

output "kvId" {
  value       = azurerm_key_vault.keyvault.id
  description = "The ID of the Key Vault."
}

output "kvUri" {
  value = azurerm_key_vault.keyvault.vault_uri
  description = "URI of the key vault "
}
