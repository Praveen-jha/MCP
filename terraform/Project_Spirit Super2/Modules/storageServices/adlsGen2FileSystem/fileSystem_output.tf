output "fileSytemName" {
  value = azurerm_storage_data_lake_gen2_filesystem.fileSystem.name
  description = "Output for File System Name"
}

output "fileSystemID" {
  value = azurerm_storage_data_lake_gen2_filesystem.fileSystem.id
  description = "Output for File System ID"
}