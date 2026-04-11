resource "azurerm_storage_container" "new_container" {
  name                  = var.containerName
  storage_account_name  = var.containerName
  container_access_type = var.containerAccessType
}
