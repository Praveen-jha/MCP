resource "azurerm_storage_container" "newcontainer" {
  name                  = var.containerName
  storage_account_name  = var.containerName
  container_access_type = var.containerAccessType
}