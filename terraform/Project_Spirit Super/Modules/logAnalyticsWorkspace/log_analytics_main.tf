resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.logWorkspaceName
  location            = var.location
  resource_group_name = var.rgName
  sku                 = var.logWorkspaceSku
  retention_in_days   = var.logRetentionInDays
  tags                = var.tags
}
