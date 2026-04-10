resource "azurerm_databricks_access_connector" "adb_connector" {
  name                = var.adb_connector_name
  resource_group_name = var.adb_connector_rg
  location            = var.adb_connector_location
  identity {
    type = var.identity_type
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [
      # tags
    ]
  }
}