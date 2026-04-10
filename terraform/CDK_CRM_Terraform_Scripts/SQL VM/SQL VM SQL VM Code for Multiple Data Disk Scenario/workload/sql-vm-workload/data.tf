#Data block for Existing Resource Group for SQL VM
data "azurerm_resource_group" "existing_resource_group_sql_vm" {
  count = var.name_config.sql_vm_resource_group_creation == "existing" ? 1 : 0
  name  = var.existing_resource_group_sql_vm_name
}

#Data block for Existing Resource Group for Virtual Network
data "azurerm_resource_group" "existing_resource_group_virtual_network" {
  count = var.name_config.virtual_network_resource_group_creation == "existing" ? 1 : 0
  name  = var.existing_resource_group_virtual_network_name
}

#Data block for Existing Virtual Network
data "azurerm_virtual_network" "existing_vnet" {
  count               = var.name_config.virtual_network_creation == "existing" ? 1 : 0
  name                = var.existing_virtual_network_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group_virtual_network[0].name
}

#Data block for Exsiting Inbound Subnet
data "azurerm_subnet" "existing_compute_subnet" {
  count                = var.name_config.subnet_creation == "existing" ? 1 : 0
  name                 = var.existing_compute_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
  resource_group_name  = data.azurerm_resource_group.existing_resource_group_virtual_network[0].name
}
