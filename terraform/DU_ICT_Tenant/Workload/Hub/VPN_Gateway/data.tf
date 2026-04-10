data "azurerm_resource_group" "hub_network_resource_group" {
  name = "ict-platform-hrbot-hub-network-rg"
}

data "azurerm_virtual_network" "hub_virtual_network" {
  name                = "ict-platform-hrbot-hub-vnet-uaen"
  resource_group_name = data.azurerm_resource_group.hub_network_resource_group.name
}

data "azurerm_subnet" "vpngw_subnet" {
  name = "GatewaySubnet"
  virtual_network_name = data.azurerm_virtual_network.hub_virtual_network.name
  resource_group_name = data.azurerm_resource_group.hub_network_resource_group.name
}