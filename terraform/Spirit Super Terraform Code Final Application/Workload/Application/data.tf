data "azurerm_resource_group" "application_rg" {
  name = var.nameConfig.existingApplicationRGName
}

data "azurerm_resource_group" "network_rg" {
  name = var.nameConfig.existingNetworkRGName
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.nameConfig.existingVnetName
  resource_group_name = data.azurerm_resource_group.network_rg.name
}

data "azurerm_subnet" "pe_subnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-pe-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_resource_group.network_rg.name
}

data "azurerm_subnet" "databricks_host_subnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-host-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_resource_group.network_rg.name
}

data "azurerm_subnet" "databricks_container_subnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-container-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_resource_group.network_rg.name
}

data "azurerm_network_security_group" "host_nsg" {
  name                = "${local.baseName2}-vnet1-${local.baseName1}-host-nsg1"
  resource_group_name = data.azurerm_resource_group.network_rg.name
}

data "azurerm_network_security_group" "container_nsg" {
  name                = "${local.baseName2}-vnet1-${local.baseName1}-container-nsg1"
  resource_group_name = data.azurerm_resource_group.network_rg.name
}
