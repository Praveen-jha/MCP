data "azurerm_virtual_network" "virtual_network" {
  name                = local.hub_virtual_network_name
  resource_group_name = local.hub_network_rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = local.compute_subnet_name
  virtual_network_name = local.hub_virtual_network_name
  resource_group_name  = local.hub_network_rg_name
}

data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.hub_network_rg_name
}
 