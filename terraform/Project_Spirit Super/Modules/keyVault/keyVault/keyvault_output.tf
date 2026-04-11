output "kvName" {
  value       = azurerm_key_vault.key_vault.name
  description = "The name of the Key Vault."
}

output "kvId" {
  value       = azurerm_key_vault.key_vault.id
  description = "The ID of the Key Vault."
}

output "kvUri" {
  value = azurerm_key_vault.key_vault.vault_uri
  description = "URI of the key vault "
}
