output "storageAccountName" {
  value       = azurerm_storage_account.storage_account.name
  description = "ouptut of storage account name"
}

output "storageAccountId" {
  value       = azurerm_storage_account.storage_account.id
  description = "output of storage account id"
}

output "storageAccountaccesskey" {
  value       = azurerm_storage_account.storage_account.primary_access_key
  description = "output of storage account access key"
}

# output "storageShareId" {
#   value       = azurerm_storage_share.storage_share.id
#   description = "ouptut of storage share id"
# }

output "storageConnectionstring" {
  value       = azurerm_storage_account.storage_account.primary_connection_string
  description = "ouptut of storage container primary connection string"
}

output "storagePrimaryBlobHost" {
  value       = azurerm_storage_account.storage_account.primary_blob_host
  description = "ouptut of storage container primary connection string"
}
