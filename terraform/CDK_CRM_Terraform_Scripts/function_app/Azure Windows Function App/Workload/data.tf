
#Data block for Existing Resource Group
data "azurerm_resource_group" "existing_resource_group" {
  count = var.name_config.resource_group_creation == "existing" ? 1 : 0
  name  = var.existing_resource_group_name
}

#Data block for Existing Virtual Network
data "azurerm_virtual_network" "existing_vnet" {
  count               = var.name_config.virtual_network_creation == "existing" ? 1 : 0
  name                = var.existing_virtual_network_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group[0].name
}

#Data block for Exsiting Inbound Subnet
data "azurerm_subnet" "existing_private_endpoint_subnet" {
  count                = var.name_config.subnet_creation == "existing" ? 1 : 0
  name                 = var.existing_private_endpoint_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
  resource_group_name  = data.azurerm_resource_group.existing_resource_group[0].name
}

#Data block for Exsiting Outbound Subnet
data "azurerm_subnet" "existing_outbound_subnet" {
  count                = (var.name_config.subnet_creation == "existing" && var.web_app_vnet_integration_enable) ? 1 : 0
  name                 = var.existing_outbound_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
  resource_group_name  = data.azurerm_resource_group.existing_resource_group[0].name
}
