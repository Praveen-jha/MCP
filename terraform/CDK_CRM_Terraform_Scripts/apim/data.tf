# This file defines the main configuration for the azurerm_api_management module.
# --- Data sources for existing resources ---

data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing" {
  count               = var.virtual_network_type != "None" ? 1 : 0
  name                = var.virtual_network_name
  resource_group_name = var.network_resource_group
}

data "azurerm_subnet" "existing" {
  count                  = var.virtual_network_type != "None" ? 1 : 0
  name                   = var.subnet_name
  resource_group_name    = var.network_resource_group
  virtual_network_name   = data.azurerm_virtual_network.existing[0].name
}

data "azurerm_subnet" "pe" {
  count                  = var.enable_private_endpoint ? 1 : 0
  name                   = var.private_endpoint_subnet_name
  resource_group_name    = var.network_resource_group
  virtual_network_name   = data.azurerm_virtual_network.existing[0].name
}

data "azurerm_public_ip" "existing" {
  count               = var.public_ip_required ? 1 : 0
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dnszone" {
  count               = var.create_private_dns_record ? 1 : 0
  provider            = azurerm.hub
  name                = var.private_zone_domain
  resource_group_name = var.private_dns_zone_rg_name
}

# --- Dynamic lookup or creation of monitoring resources ---

# Look for an existing Log Analytics Workspace
data "azurerm_log_analytics_workspace" "existing" {
  count               = var.log_analytics_workspace_name != "" ? 1 : 0
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
}

# Look for an existing Application Insights instance
data "azurerm_application_insights" "existing" {
  count               = var.application_insights_name != "" ? 1 : 0
  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
}
