output "storage_account_id" {
  description = "Output: Azure Storage Account resource object"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "Output: Azure Storage Account resource object"
  value       = azurerm_storage_account.storage.name
}