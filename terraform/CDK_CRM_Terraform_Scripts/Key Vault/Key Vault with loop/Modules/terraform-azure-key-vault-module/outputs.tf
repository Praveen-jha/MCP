#outputs.tf
#Outputs Key Vault ID, name, and resource group only if the Key Vault is created; otherwise returns null.

output "key_vault" {
  value = var.create_kv ? azurerm_key_vault.this[0] : null
  description = "The entire resource object for the Key Vault."
}
output "key_vault_id" {
  value       = var.create_kv ? azurerm_key_vault.this[0].id : null
  description = "Output: Azure Key Vault resource object"
}

output "key_vault_name" {
  description = "Output: Name of Azure Key Vault"
  value       = var.create_kv ? azurerm_key_vault.this[0].name : null
}

output "resource_group_name" {
  description = "Output: That resource group name in which our key vault exist."
  value       = var.create_kv ? azurerm_key_vault.this[0].resource_group_name : null
}
