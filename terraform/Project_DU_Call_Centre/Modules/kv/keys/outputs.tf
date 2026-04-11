output "key_vault_key_id" {
  description = "Output: Azure Key Vault Key resource object"
  value       = azurerm_key_vault_key.key_vault_key.id
}

output "key_versionless_id" {
  description = "value"
  value       = azurerm_key_vault_key.key_vault_key.resource_versionless_id
}
