resource "azurerm_storage_data_lake_gen2_filesystem" "fileSystem" {
  name               = var.fileSystemName
  storage_account_id = var.storageAccountId
}