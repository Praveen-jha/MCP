data "azurerm_resource_group" "spoke_rg" {
  name = var.networking.spoke_rg_name
}

data "azurerm_virtual_network" "spoke_vnet" {
  name                = var.networking.spoke_vnet_name
  resource_group_name = data.azurerm_resource_group.spoke_rg.name
}

data "azurerm_subnet" "dbx_host_subnet" {
  name                 = var.networking.dbx_host_subnet
  virtual_network_name = data.azurerm_virtual_network.spoke_vnet.name
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
}

data "azurerm_subnet" "dbx_container_subnet" {
  name                 = var.networking.dbx_container_subnet
  virtual_network_name = data.azurerm_virtual_network.spoke_vnet.name
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
}

data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = var.networking.spoke_pep_subnet
  virtual_network_name = data.azurerm_virtual_network.spoke_vnet.name
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
}

data "azurerm_subnet" "compute_subnet" {
  name                 = var.networking.spoke_compute_subnet
  virtual_network_name = data.azurerm_virtual_network.spoke_vnet.name
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
}

