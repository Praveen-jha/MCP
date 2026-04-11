# ......................................................
# Creating New Resource Group
# ......................................................

module "rg" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.app_rg_name
  resource_group_location = var.rg_location
}

# ......................................................
# Creating Node App Service
# ......................................................

module "node_app_service" {
  source                                          = "../../../Modules/node_app_service"
  node_app_service_plan_name                      = local.node_app_service_plan_name
  node_app_service_plan_os_type                   = var.node_app_service_plan_os_type
  node_app_service_plan_sku                       = var.node_app_service_plan_sku
  location                                        = local.location
  resource_group_name                             = local.resource_group_name
  node_app_service_name                           = local.node_app_service_name
  node_app_subnet_id                              = data.azurerm_subnet.node_as_subnet.id
  node_version                                    = var.node_version
  vnet_route_all_enabled                          = local.vnet_route_all_enabled
  current_stack                                   = var.current_stack
  public_network_access_enabled                   = local.public_network_access_enabled_node_as
  https_only                                      = var.https_only
  minimum_tls_version                             = var.minimum_tls_version
  application_insights_instrumentation_key        = module.application_insights.instrumentation_key
  application_insights_connection_string          = module.application_insights.connection_string
  appinsights_profilerfeature_version             = var.appinsights_profilerfeature_version
  appinsights_snapshotfeature_version             = var.appinsights_snapshotfeature_version
  applicationinsightsagent_extension_version      = var.applicationinsightsagent_extension_version
  diagnosticservices_extension_version            = var.diagnosticservices_extension_version
  instrumentationengine_extension_version         = var.instrumentationengine_extension_version
  snapshotdebugger_extension_version              = var.snapshotdebugger_extension_version
  xdt_microsoftapplicationinsights_baseextensions = var.xdt_microsoftapplicationinsights_baseextensions
  xdt_microsoftapplicationinsights_mode           = var.xdt_microsoftapplicationinsights_mode
  identity_type                                   = var.identity_type
  identity_ids                                    = [data.azurerm_user_assigned_identity.uaid.id]
  REACT_APP_API_URL                               = var.REACT_APP_API_URL
  tags                                            = var.node_app_tags
  depends_on                                      = [module.rg, module.application_insights]
}

# ......................................................
# Creating Python App Service
# ......................................................

module "python_app_service" {
  source                                          = "../../../Modules/python_app_service"
  python_app_service_plan_name                    = local.python_app_service_plan_name
  python_app_service_plan_os_type                 = var.python_app_service_plan_os_type
  python_app_service_plan_sku                     = var.python_app_service_plan_sku
  location                                        = local.location
  resource_group_name                             = local.resource_group_name
  python_app_service_name                         = local.python_app_service_name
  python_app_subnet_id                            = data.azurerm_subnet.python_as_subnet.id
  public_network_access_enabled                   = local.public_network_access_enabled_python_as
  python_version                                  = var.python_version
  vnet_route_all_enabled                          = local.vnet_route_all_enabled
  https_only                                      = var.https_only
  minimum_tls_version                             = var.minimum_tls_version
  application_insights_instrumentation_key        = module.application_insights.instrumentation_key
  application_insights_connection_string          = module.application_insights.connection_string
  appinsights_profilerfeature_version             = var.appinsights_profilerfeature_version
  appinsights_snapshotfeature_version             = var.appinsights_snapshotfeature_version
  applicationinsightsagent_extension_version      = var.applicationinsightsagent_extension_version
  diagnosticservices_extension_version            = var.diagnosticservices_extension_version
  instrumentationengine_extension_version         = var.instrumentationengine_extension_version
  snapshotdebugger_extension_version              = var.snapshotdebugger_extension_version
  xdt_microsoftapplicationinsights_baseextensions = var.xdt_microsoftapplicationinsights_baseextensions
  xdt_microsoftapplicationinsights_mode           = var.xdt_microsoftapplicationinsights_mode
  SCM_DO_BUILD_DURING_DEPLOYMENT                  = var.SCM_DO_BUILD_DURING_DEPLOYMENT
  identity_type                                   = var.identity_type
  identity_ids                                    = [data.azurerm_user_assigned_identity.uaid.id]
  tags                                            = var.python_app_tags
  OPENAI_API_KEY                                  = var.OPENAI_API_KEY
  depends_on                                      = [module.rg, module.application_insights]
}

# ......................................................
# Creating Node App Service for UAT
# ......................................................

module "node_app_service_uat" {
  source                                          = "../../../Modules/node_app_service"
  node_app_service_plan_name                      = local.node_app_service_plan_uat_name
  node_app_service_plan_os_type                   = var.node_app_service_plan_os_type
  node_app_service_plan_sku                       = var.node_app_service_plan_sku
  location                                        = local.location
  resource_group_name                             = local.resource_group_name
  node_app_service_name                           = local.node_app_service_uat_name
  node_app_subnet_id                              = data.azurerm_subnet.node_as_subnet.id
  node_version                                    = var.node_version
  vnet_route_all_enabled                          = local.vnet_route_all_enabled
  current_stack                                   = var.current_stack
  public_network_access_enabled                   = local.public_network_access_enabled_node_as
  https_only                                      = var.https_only
  minimum_tls_version                             = var.minimum_tls_version
  application_insights_instrumentation_key        = module.application_insights.instrumentation_key
  application_insights_connection_string          = module.application_insights.connection_string
  appinsights_profilerfeature_version             = var.appinsights_profilerfeature_version
  appinsights_snapshotfeature_version             = var.appinsights_snapshotfeature_version
  applicationinsightsagent_extension_version      = var.applicationinsightsagent_extension_version
  diagnosticservices_extension_version            = var.diagnosticservices_extension_version
  instrumentationengine_extension_version         = var.instrumentationengine_extension_version
  snapshotdebugger_extension_version              = var.snapshotdebugger_extension_version
  xdt_microsoftapplicationinsights_baseextensions = var.xdt_microsoftapplicationinsights_baseextensions
  xdt_microsoftapplicationinsights_mode           = var.xdt_microsoftapplicationinsights_mode
  identity_type                                   = var.identity_type
  identity_ids                                    = [data.azurerm_user_assigned_identity.uaid.id]
  REACT_APP_API_URL                               = var.REACT_APP_API_URL
  tags                                            = var.node_app_uat_tags
  depends_on                                      = [module.rg, module.application_insights]
}

# ......................................................
# Creating Python App Service for UAT
# ......................................................

module "python_app_service_uat" {
  source                                          = "../../../Modules/python_app_service"
  python_app_service_plan_name                    = local.python_app_service_plan_uat_name
  python_app_service_plan_os_type                 = var.python_app_service_plan_os_type
  python_app_service_plan_sku                     = var.python_app_service_plan_sku
  location                                        = local.location
  resource_group_name                             = local.resource_group_name
  python_app_service_name                         = local.python_app_service_uat_name
  python_app_subnet_id                            = data.azurerm_subnet.python_as_subnet.id
  public_network_access_enabled                   = local.public_network_access_enabled_python_as
  python_version                                  = var.python_version
  vnet_route_all_enabled                          = local.vnet_route_all_enabled
  https_only                                      = var.https_only
  minimum_tls_version                             = var.minimum_tls_version
  application_insights_instrumentation_key        = module.application_insights.instrumentation_key
  application_insights_connection_string          = module.application_insights.connection_string
  appinsights_profilerfeature_version             = var.appinsights_profilerfeature_version
  appinsights_snapshotfeature_version             = var.appinsights_snapshotfeature_version
  applicationinsightsagent_extension_version      = var.applicationinsightsagent_extension_version
  diagnosticservices_extension_version            = var.diagnosticservices_extension_version
  instrumentationengine_extension_version         = var.instrumentationengine_extension_version
  snapshotdebugger_extension_version              = var.snapshotdebugger_extension_version
  xdt_microsoftapplicationinsights_baseextensions = var.xdt_microsoftapplicationinsights_baseextensions
  xdt_microsoftapplicationinsights_mode           = var.xdt_microsoftapplicationinsights_mode
  SCM_DO_BUILD_DURING_DEPLOYMENT                  = var.SCM_DO_BUILD_DURING_DEPLOYMENT
  identity_type                                   = var.identity_type
  identity_ids                                    = [data.azurerm_user_assigned_identity.uaid.id]
  tags                                            = var.python_app_uat_tags
  OPENAI_API_KEY                                  = var.OPENAI_API_KEY
  depends_on                                      = [module.rg, module.application_insights]
}

# ......................................................
# Creating Application Insights
# ......................................................

module "application_insights" {
  source                     = "../../../Modules/applicationInsights"
  name                       = local.application_insights
  resource_group_name        = local.resource_group_name
  location                   = local.location
  application_type           = var.application_type
  log_analytics_workspace_id = var.log_analytics_workspace_id
  depends_on                 = [module.rg]
}

# ......................................................
# Creating Diagnostic settings for Python App
# ......................................................

module "diagnostic_setting_py_app" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_py_app_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = module.python_app_service.app_service_id
  enabled_log                = local.enabled_logs_py_app
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.python_app_service]
}

# ......................................................
# Creating Diagnostic settings for Node App
# ......................................................

module "diagnostic_setting_node_app" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_node_app_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = module.node_app_service.node_app_id
  enabled_log                = local.enabled_logs_node_app
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.node_app_service]
}

module "python_app_service_deployment_slot" {
  source                                          = "../../../Modules/python_app_deployment_slot"
  python_deployment_slot_name                     = local.python_deployment_slot_name
  app_service_id                                  = module.python_app_service.app_service_id
  python_app_subnet_id                            = data.azurerm_subnet.python_as_subnet.id
  public_network_access_enabled                   = local.public_network_access_enabled_python_as
  python_version                                  = var.python_version
  vnet_route_all_enabled                          = local.vnet_route_all_enabled
  https_only                                      = var.https_only
  minimum_tls_version                             = var.minimum_tls_version
  application_insights_instrumentation_key        = module.application_insights.instrumentation_key
  application_insights_connection_string          = module.application_insights.connection_string
  appinsights_profilerfeature_version             = var.appinsights_profilerfeature_version
  appinsights_snapshotfeature_version             = var.appinsights_snapshotfeature_version
  applicationinsightsagent_extension_version      = var.applicationinsightsagent_extension_version
  diagnosticservices_extension_version            = var.diagnosticservices_extension_version
  instrumentationengine_extension_version         = var.instrumentationengine_extension_version
  snapshotdebugger_extension_version              = var.snapshotdebugger_extension_version
  xdt_microsoftapplicationinsights_baseextensions = var.xdt_microsoftapplicationinsights_baseextensions
  xdt_microsoftapplicationinsights_mode           = var.xdt_microsoftapplicationinsights_mode
  SCM_DO_BUILD_DURING_DEPLOYMENT                  = var.SCM_DO_BUILD_DURING_DEPLOYMENT
  identity_type                                   = var.identity_type
  identity_ids                                    = [data.azurerm_user_assigned_identity.uaid.id]
  depends_on                                      = [module.rg, module.application_insights]
}

# ......................................................
# Creating Action Group
# ......................................................

module "action_group" {
  source                 = "../../../Modules/monitor_action_group"
  action_group_name      = local.action_group_name
  action_group_shortname = local.action_group_shortname
  resource_group_name    = local.resource_group_name
  email_receivers        = local.email_receivers
  depends_on             = [module.rg]
}

# ......................................................
# Creating Metric Alert Node App
# ......................................................

module "alert_frontend" {
  source              = "../../../Modules/monitor_metric_alert"
  metric_alert_name   = local.metric_alert_frontend_name
  resource_group_name = local.resource_group_name
  action_group_id     = module.action_group.action_group_id
  description         = local.alert_frontend_description
  criteria_config     = local.criteria_config
  scopes              = [module.node_app_service.node_app_id]
  depends_on          = [module.rg, module.action_group, module.node_app_service]
}

# ......................................................
# Creating Metric Alert for Python App
# ......................................................

module "alert_backend" {
  source              = "../../../Modules/monitor_metric_alert"
  metric_alert_name   = local.metric_alert_backend_name
  resource_group_name = local.resource_group_name
  action_group_id     = module.action_group.action_group_id
  description         = local.alert_backend_description
  criteria_config     = local.criteria_config
  scopes              = [module.python_app_service.app_service_id]
  depends_on          = [module.rg, module.action_group, module.python_app_service]
}
