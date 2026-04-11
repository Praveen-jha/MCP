resource "azurerm_databricks_access_connector" "databricks_access_connector" {
  name                = var.databricksAccessConnectorName
  resource_group_name = var.rgName
  location            = var.location
  identity {
    type = "SystemAssigned"
  }
  tags                = var.tags
}
