# Manages a Container within an Azure Storage Account.
resource "azurerm_storage_container" "storage_container" {
  name                  = var.storage_container_name
  # storage_account_id    = var.storage_account_id
  storage_account_name = var.storage_account_name
  lifecycle {
    ignore_changes = all
  }
}
