output "id" {
  description = "The ID of the Storage Queue"
  value       = azurerm_storage_queue.this.id
}

output "name" {
  description = "The name of the Storage Queue"
  value       = azurerm_storage_queue.this.name
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_queue.this.storage_account_name
}

output "metadata" {
  description = "The metadata assigned to this Storage Queue"
  value       = azurerm_storage_queue.this.metadata
}

output "url" {
  description = "The URL of the Storage Queue"
  value       = "https://${azurerm_storage_queue.this.storage_account_name}.queue.core.windows.net/${azurerm_storage_queue.this.name}"
}
