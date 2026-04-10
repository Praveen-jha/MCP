# Create a new Log Analytics Workspace if one isn't provided
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
# Create a new Log Analytics Workspace if one isn't provided
resource "azurerm_log_analytics_workspace" "new" {
  count               = var.log_analytics_workspace_enabled && var.log_analytics_workspace_name == "" ? 1 : 0
  name                = "logAnalytics${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name_log_analytics
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}