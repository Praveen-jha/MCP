output "fileSytemName" {
  value = azurerm_storage_data_lake_gen2_filesystem.file_system.name
  description = "Output for File System Name"
}

output "fileSystemID" {
  value = azurerm_storage_data_lake_gen2_filesystem.file_system.id
  description = "Output for File System ID"
}
