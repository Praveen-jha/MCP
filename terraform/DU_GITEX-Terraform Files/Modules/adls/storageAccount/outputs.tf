output "storage_account_id" {
  description = "Output: Azure Storage Account resource object"
  value       = azurerm_storage_account.storage.id
}
output "storage_account_key" {
  value = azurerm_storage_account.storage.primary_access_key
}

output "storage_account_connection_string" {
  value = azurerm_storage_account.storage.primary_connection_string
}

