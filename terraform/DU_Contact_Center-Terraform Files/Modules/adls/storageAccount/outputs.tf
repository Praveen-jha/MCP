output "storage_account_id" {
    description = "Output: Azure Storage Account resource object"
    value       = azurerm_storage_account.storage.id
}

output "primary_access_key" {
  description = "Output: Azure Storage Account primary_access_key"
  value       = azurerm_storage_account.storage.primary_access_key
}
