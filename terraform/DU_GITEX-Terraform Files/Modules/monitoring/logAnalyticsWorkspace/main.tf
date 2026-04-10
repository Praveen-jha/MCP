# Create an Azure Log Analytics workspace with the specified name, location, resource group, SKU, and retention period.
resource "azurerm_log_analytics_workspace" "log" {
  name                = var.log_workspace_name
  location            = var.log_location
  resource_group_name = var.log_resource_group_name
  retention_in_days   = var.log_retention_in_days
  tags              = var.logAnalytics_tags

}
