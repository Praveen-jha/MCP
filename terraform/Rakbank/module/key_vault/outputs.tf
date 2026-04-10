output "key_vault_id" {
  value       = azurerm_key_vault.kv.id
  description = "Output: Azure Key Vault resource object"
}

output "key_vault_name" {
  description = "Output: Name of Azure Key Vault"
  value       = azurerm_key_vault.kv.name
}

output "resource_group_name" {
  description = "Output: That resource group name in which our key vault exist."
  value       = azurerm_key_vault.kv.resource_group_name
}
