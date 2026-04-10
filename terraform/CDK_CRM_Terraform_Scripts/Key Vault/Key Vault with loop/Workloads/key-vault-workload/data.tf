#Data block for Existing Resource Group for Web App
data "azurerm_resource_group" "existing_resource_group_kv" {
  count = var.name_config.kv_resource_group_creation == "existing" ? 1 : 0
  name  = var.existing_resource_group_kv_name
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
data "azurerm_subnet" "existing_private_endpoint_subnet" {
  count                = (var.name_config.subnet_creation == "existing" && var.public_network_access_enabled == false) ? 1 : 0
  name                 = var.existing_private_endpoint_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
  resource_group_name  = data.azurerm_resource_group.existing_resource_group_virtual_network[0].name
}

# Current client (Infra UAMI) must have access to run this workload successfully
data "azurerm_client_config" "current" {}