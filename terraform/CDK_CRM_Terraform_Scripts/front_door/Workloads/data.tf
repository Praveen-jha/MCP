data "azurerm_resource_group" "rg" {
  name       = local.resource_group_name
  depends_on = [azurerm_resource_group.rg]
}
