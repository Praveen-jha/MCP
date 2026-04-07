data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
}
data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = var.private_endpoint_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
}
data "azurerm_subnet" "databricks_host_subnet" {
  name                 = var.databricks_host_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
}
data "azurerm_subnet" "databricks_container_subnet" {
  name                 = var.databricks_container_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
}
data "azurerm_subnet" "logic_app_subnet" {
  name                 = var.logicapp_integration_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
}
