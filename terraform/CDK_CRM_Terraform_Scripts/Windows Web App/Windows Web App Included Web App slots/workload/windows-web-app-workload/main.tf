#Creation of Resource Group
module "resource_group" {
  source                  = "../../module/terraform-azure-resource-group-module"
  count                   = var.name_config.web_app_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_web_app_resource_group_name
  resource_group_location = var.location
  resource_group_tags     = var.tags
}


#Creation of Application Insights
module "application_insights" {
  source                    = "../../module/terraform-azure-application-insights-module"
  count                     = var.enable_application_insights ? 1 : 0
  application_insights_name = local.application_insights_name
  location                  = var.location
  resource_group_name       = local.resource_group_name
  application_type          = var.application_insights_application_type
  retention_in_days         = var.application_insights_retention_in_days
  workspace_id              = var.application_insights_workspace_id
  tags                      = var.tags
  depends_on                = [module.resource_group]
}


#Creation of App Service Plan
module "app_service_plan" {
  source                          = "../../module/terraform-azure-app-service-plan-module"
  for_each                        = var.app_service_mapping
  app_service_plan_name           = each.key
  location                        = var.location
  resource_group_name             = local.resource_group_name
  sku_name                        = each.value.config.sku_name
  os_type                         = each.value.config.os_type
  maximum_elastic_worker_count    = lookup(each.value.config, "maximum_elastic_worker_count", null)
  worker_count                    = lookup(each.value.config, "worker_count", null)
  per_site_scaling_enabled        = lookup(each.value.config, "per_site_scaling_enabled", null)
  premium_plan_auto_scale_enabled = lookup(each.value.config, "premium_plan_auto_scale_enabled", null)
  zone_balancing_enabled          = lookup(each.value.config, "zone_balancing_enabled", null)
  tags                            = var.tags
  depends_on                      = [module.resource_group]
}


#Creatin of Windows Web App
module "windows_web_app" {
  source                        = "../../module/terraform-azure-windows-web-app-module"
  for_each                      = local.web_apps_for_each
  windows_web_app_name          = each.value.web_app_name
  location                      = var.location
  resource_group_name           = local.resource_group_name
  service_plan_id               = module.app_service_plan[each.value.app_service_plan_name].app_service_plan_id
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.web_app_vnet_integration_enable ? data.azurerm_subnet.existing_outbound_subnet[0].id : null
  site_config                   = each.value.web_app_site_config
  app_settings = var.enable_application_insights ? merge(
    each.value.web_app_app_settings,
    {
      "APPINSIGHTS_CONNECTION_STRING"                   = module.application_insights[0].application_insights_connection_string
      "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~2"
      "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
      "APPINSIGHTS_INSTRUMENTATIONKEY"                  = module.application_insights[0].application_insights_instrumentation_key
      "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
      "DiagnosticServices_EXTENSION_VERSION"            = "~3"
      "InstrumentationEngine_EXTENSION_VERSION"         = "~2"
      "SnapshotDebugger_EXTENSION_VERSION"              = "1.0.15"
      "XDT_MicrosoftApplicationInsights_BaseExtensions" = "enabled"
    }
  ) : each.value.web_app_app_settings
  depends_on = [module.app_service_plan, module.application_insights, module.resource_group]
}


#Creation of Windwos Web App Slots
module "windows_web_app_slot" {
  source                        = "../../module/terraform-azure-windows-web-app-slot-module"
  for_each                      = local.web_app_slots_for_each
  web_app_slot_name             = each.value.slot_name
  app_service_id                = module.windows_web_app[each.value.parent_web_app_key].windows_web_app_id
  public_network_access_enabled = each.value.slot_public_network_access_enabled
  virtual_network_subnet_id     = each.value.slot_vnet_integration_enable ? data.azurerm_subnet.existing_outbound_subnet[0].id : null
  site_config                   = each.value.slot_site_config
  app_settings = each.value.enable_application_insights ? merge(
    each.value.slot_app_settings,
    {
      "APPINSIGHTS_CONNECTION_STRING"                   = module.application_insights[0].application_insights_connection_string
      "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~2"
      "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
      "APPINSIGHTS_INSTRUMENTATIONKEY"                  = module.application_insights[0].application_insights_instrumentation_key
      "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
      "DiagnosticServices_EXTENSION_VERSION"            = "~3"
      "InstrumentationEngine_EXTENSION_VERSION"         = "~2"
      "SnapshotDebugger_EXTENSION_VERSION"              = "1.0.15"
      "XDT_MicrosoftApplicationInsights_BaseExtensions" = "enabled"
    }
  ) : each.value.slot_app_settings
  depends_on = [module.windows_web_app, module.app_service_plan, module.application_insights, module.resource_group]
}


#Creation of Private Endpoint for Windows Web App
module "windows_web_app_private_endpoint" {
  source                          = "../../module/terraform-azure-private-endpoint-module"
  for_each                        = local.private_endpoints_for_each
  private_endpoint_name           = each.value.web_app_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = each.value.private_service_connection_name
  subresource_names               = each.value.subresource_names
  private_connection_resource_id  = module.windows_web_app[each.key].windows_web_app_id
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_group_name     = each.value.private_dns_zone_group_name
  private_dns_zone_ids            = var.web_app_private_dns_zone_id
  depends_on                      = [module.windows_web_app, module.app_service_plan, module.resource_group, module.windows_web_app_slot]
}
