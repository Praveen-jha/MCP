data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.hub_network_rg_name
}

data "azurerm_log_analytics_workspace" "law" {
  name                = var.LAW_name
  resource_group_name = var.monitor_rg_name
}