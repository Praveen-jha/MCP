#Create new resource group
module "monitor_resource_group" {
  source                  = "../../../Modules/rg"
  resource_group_name     = local.monitor_resource_group_name
  resource_group_location = var.location
}

#Create Log Analytics Workspace
module "log_analytics_workspace" {
  source             = "../../../Modules/monitoring/logAnalyticsWorkspace"
  law_name           = local.law_name
  law_location       = var.location
  law_resource_group = local.monitor_resource_group_name
  law_retention_days = var.law_retention_days
  law_tags           = var.law_tags
  depends_on         = [module.monitor_resource_group]
}