data "azurerm_resource_group" "data_governance_rg" {
  name = var.nameConfig.existingdataGovernanceRGName
}

data "azurerm_virtual_network" "platform" {
  name                = var.nameConfig.existingVnetName
  resource_group_name = var.nameConfig.existingNetworkRGName
}

data "azurerm_subnet" "pe_subnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-pe-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_virtual_network.platform.resource_group_name
}

data "azurerm_private_dns_zone" "purview_ingestion_blob_private_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "private-dns-rg"
}

data "azurerm_private_dns_zone" "purview_ingestion_dfs_private_dns_zone" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = "private-dns-rg"
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${local.baseName1}-logbg"
  resource_group_name = var.nameConfig.existingApplicationRGName
}
