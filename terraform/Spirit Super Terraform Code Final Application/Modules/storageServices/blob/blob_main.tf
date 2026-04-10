resource "azurerm_storage_blob" "new_blob" {
  name                   = var.blobName
  storage_account_name   = var.storageAccountName
  storage_container_name = var.containerName
  type                   = var.blobType
  access_tier            = var.blobAccessTier
  source                 = var.blobSource
}
