#Data block for Existing Resource Group
data "azurerm_resource_group" "existing_resource_group" {
  count = var.nameConfig.rg_creation == "existing" ? 1 : 0
  name  = var.existing_resource_group_name
}

#Data block for Existing Virtual Network
data "azurerm_virtual_network" "existing_vnet" {
  count               = var.nameConfig.vnet_creation == "existing" ? 1 : 0
  name                = var.existing_virtual_network_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group[0].name
}


#Data block for Exsiting Subnet
data "azurerm_subnet" "existing_subnet" {
  count                = var.nameConfig.subnet_creation == "existing" ? 1 : 0
  name                 = var.existing_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
  resource_group_name  = data.azurerm_resource_group.existing_resource_group[0].name
}

#Data block for Network Security Group
data "azurerm_network_security_group" "exisitng_network_security_group" {
  count               = var.nameConfig.nsg_creation == "existing" ? 1 : 0
  name                = var.exisitng_network_security_group_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group[0].name
}
