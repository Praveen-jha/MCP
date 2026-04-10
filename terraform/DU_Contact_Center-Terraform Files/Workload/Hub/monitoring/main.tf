#Create new resource group
module "monitor_resource_group" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.monitor_rg_name
  resource_group_location = var.monitor_resource_group_location
  resource_group_tags     = var.resource_group_tags
}

#Create Log Analytics Workspace
module "log_analytics_workspace" {
  source             = "../../../Modules/monitoring/logAnalyticsWorkspace"
  law_name           = local.law_name
  law_location       = var.monitor_resource_group_location
  law_resource_group = local.monitor_rg_name
  law_retention_days = var.law_retention_days
  law_tags           = var.law_tags
  depends_on         = [module.monitor_resource_group]
}
 
# ......................................................
# Creating Diagnostic settings for Firewall
# ......................................................

module "diagnostic_setting_fw" {
  source                     = "../../../Modules/monitoring/diagnosticSettings"
  diagnostic_setting_name    = local.diagnostic_setting_Name
  log_analytics_workspace_id = module.log_analytics_workspace.law_id
  target_resource_id         = data.azurerm_firewall.firewall.id
  enabled_log                = local.enabled_logs
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.log_analytics_workspace]
}