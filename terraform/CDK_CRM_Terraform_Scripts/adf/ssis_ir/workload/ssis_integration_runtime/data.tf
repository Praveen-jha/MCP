#Data block for Existing Azure Data Factory
data "azurerm_data_factory" "existing_data_factory" {
  name                = var.data_factory_name
  resource_group_name = var.existing_data_factory_rg_name
}

#Data block for User Assigned Identity
data "azurerm_user_assigned_identity" "existing_user_assigned_identity" {
  count               = var.identity_type == "UserAssigned" ? 1 : 0
  name                = var.existing_user_assigned_identity_name
  resource_group_name = var.existing_user_assigned_identity_rg_name
}

#Data block for Existing Resource Group for Virtual Network
data "azurerm_resource_group" "existing_resource_group_virtual_network" {
  count = var.name_config.virtual_network_resource_group_creation == "existing" ? 1 : 0
  name  = var.existing_vnet_rg_name
}

#Data block for Existing Virtual Network
data "azurerm_virtual_network" "existing_vnet" {
  count               = var.name_config.virtual_network_creation == "existing" ? 1 : 0
  name                = var.existing_virtual_network_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group_virtual_network[0].name
}

#Data block for Exsiting Inbound Subnet
data "azurerm_subnet" "existing_ssis_subnet" {
  count                = (var.name_config.subnet_creation == "existing") ? 1 : 0
  name                 = var.existing_private_ssis_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
  resource_group_name  = data.azurerm_resource_group.existing_resource_group_virtual_network[0].name
}
