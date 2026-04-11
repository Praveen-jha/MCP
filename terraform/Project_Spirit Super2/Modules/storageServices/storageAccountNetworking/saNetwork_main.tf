resource "azurerm_storage_account_network_rules" "example" {
  storage_account_id         = var.storageAccountID
  default_action             = var.defaultAction
}