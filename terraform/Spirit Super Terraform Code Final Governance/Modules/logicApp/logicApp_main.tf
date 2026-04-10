resource "azurerm_logic_app_workflow" "name" {
  name                = var.logicAppName
  location            = var.location
  resource_group_name = var.resourceGroupName
  tags                = var.tags
}