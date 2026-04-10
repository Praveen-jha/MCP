data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = var.resource_group_name
}

data "azuread_group" "mi_admin" {
  display_name = var.ad_group_display_name
}

data "azurerm_subnet" "subnet_sqlmi" {
  name                 = var.sql_mi_subnet_name
  virtual_network_name = var.pep_same_vnet_virtual_network_name
  resource_group_name  = var.pep_same_vnet_resource_group_name
}

data "azurerm_subnet" "pep_subnet_same_vnet" {
  count                = var.private_endpoint_same_vnet ? 1 : 0
  name                 = var.pep_same_vnet_subnet_name
  virtual_network_name = var.pep_same_vnet_virtual_network_name
  resource_group_name  = var.pep_same_vnet_resource_group_name
}

data "azurerm_subnet" "pep_subnet_diff_vnet" {
  count                = var.private_endpoint_diff_vnet ? 1 : 0
  name                 = var.pep_diff_vnet_subnet_name
  virtual_network_name = var.pep_diff_vnet_virtual_network_name
  resource_group_name  = var.pep_diff_vnet_resource_group_name
}