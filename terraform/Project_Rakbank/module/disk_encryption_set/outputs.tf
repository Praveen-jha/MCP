output "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set"
  value       = azurerm_disk_encryption_set.disk_ency_set.id
}

output "principal_id" {
  description = "The Principle Id of the disk encryption set"
  value       = azurerm_disk_encryption_set.disk_ency_set.identity[0].principal_id
}
