output "storage_account" {
  description = "Output: Azure Storage Account resource object"
  value       = azurerm_storage_account.storage
}

output "storage_account_id" {
  description = "Map of all created Storage Accounts"
  value       = azurerm_storage_account.storage.id
}
