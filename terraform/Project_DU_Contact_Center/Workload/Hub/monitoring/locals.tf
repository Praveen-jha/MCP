locals {
  law_name                = "${var.tenant_name}-platform-${var.environment}-law-${var.location_shortname}-01"
  resource_group_name     = var.rg_creation == "new" ? module.monitor_resource_group[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location                = var.rg_creation == "new" ? module.monitor_resource_group[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location
  monitor_rg_name         = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
  diagnostic_setting_Name = "${var.tenant_name}-platform-${var.environment}-afw-diagnostics"
  firwall_name            = "ict-platform-shrd-hub-afw-uaen-01"
  hub_rg_name             = "ict-platform-shrd-hub-network-rg-uaen-01"
  enabled_logs = {
    category        = []
    category_groups = ["allLogs"]
  }
  metrics = ["AllMetrics"]

}

 
