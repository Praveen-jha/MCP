resource "azurerm_log_analytics_workspace" "law" {
  name = var.law_name
  location = var.law_location
  resource_group_name = var.law_resource_group
  retention_in_days = var.law_retention_days
  tags = var.law_tags
}