#Data block for Existing Resource Group for Web App
data "azurerm_resource_group" "existing_resource_group_sql_mi" {
  count = var.name_config.sql_mi_resource_group_creation == "existing" ? 1 : 0
  name  = var.existing_resource_group_sql_mi_name
}

#Data block for Exsiting Private Endpoint Subnet in Same Virtual Network as that for SQL MI
data "azurerm_subnet" "existing_private_endpoint_subnet_same_vnet" {
  count                = ((var.name_config.subnet_creation) == "existing" && (var.public_network_access_enabled == false) && (var.private_endpoint_same_vnet)) ? 1 : 0
  name                 = var.existing_pep_same_vnet_subnet_name
  virtual_network_name = var.existing_pep_same_vnet_virtual_network_name
  resource_group_name  = var.existing_pep_same_vnet_resource_group_name
}

#Data block for Exsiting Private Endpoint Subnet in Different Virtual Network as that for SQL MI
data "azurerm_subnet" "existing_private_endpoint_subnet_diff_vnet" {
  count                = ((var.name_config.subnet_creation == "existing") && (var.public_network_access_enabled == false) && (var.private_endpoint_diff_vnet)) ? 1 : 0
  name                 = var.existing_pep_diff_vnet_subnet_name
  virtual_network_name = var.existing_pep_diff_vnet_virtual_network_name
  resource_group_name  = var.existing_pep_diff_vnet_resource_group_name
}

#Data block for Exsiting Outbound Subnet
data "azurerm_subnet" "existing_outbound_subnet" {
  count                = var.name_config.subnet_creation == "existing" ? 1 : 0
  name                 = var.existing_sqlmi_subnet_name
  virtual_network_name = var.existing_pep_same_vnet_virtual_network_name
  resource_group_name  = var.existing_pep_same_vnet_resource_group_name
}
