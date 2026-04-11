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
  node_app_subnet_id                              = local.node_app_vnet_integration
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
  REACT_APP_API_URL                               = var.REACT_APP_API_URL
  identity_ids                                    = [data.azurerm_user_assigned_identity.uaid.id]
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
  OPENAI_API_KEY                                  = var.OPENAI_API_KEY
  identity_ids                                    = [data.azurerm_user_assigned_identity.uaid.id]
  tags                                            = var.python_app_tags
  depends_on                                      = [module.rg, module.application_insights]
}

# ......................................................
# Creating Application insights
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

# ......................................................
# Creating Budget
# ......................................................

module "budget" {
  source       = "../../../Modules/budgetAlert"
  budgetName   = local.budgetName
  amount       = var.amount
  timeGrain    = var.timeGrain
  startDate    = var.startDate
  endDate      = var.endDate
  notification = local.notification
  depends_on   = [module.rg, module.action_group]
}

# ......................................................
# Creating Node App service Plan Auto Scaling
# ......................................................

module "node_app_autoscale" {
  source                             = "../../../Modules/auto_scaling"
  autoscale_setting_name             = local.node_app_autoscale_name
  resource_group_name                = local.resource_group_name
  location                           = local.location
  target_resource_id                 = module.node_app_service.node_app_service_plan_id
  autoscale_min_capacity             = var.node_autoscale_min_capacity
  autoscale_max_capacity             = var.node_autoscale_max_capacity
  autoscale_default_capacity         = var.node_autoscale_default_capacity
  cpu_metric_threshold_increase      = var.node_cpu_metric_threshold_increase
  cpu_metric_threshold_decrease      = var.node_cpu_metric_threshold_decrease
  increase_scale_action_change_count = var.node_increase_scale_action_change_count
  decrease_scale_action_change_count = var.node_decrease_scale_action_change_count
  scale_action_cooldown              = var.node_scale_action_cooldown
  operator_decrease                  = var.node_operator_decrease
  operator_increase                  = var.node_operator_increase
  cpu_metric_name                    = local.cpu_metric_name
  statistic                          = var.node_statistic
  time_aggregation                   = var.node_time_aggregation
  time_grain                         = var.node_time_grain
  time_window                        = var.node_time_window
  depends_on                         = [module.rg, module.node_app_service]
}

# ......................................................
# Creating Python App service Plan Auto Scaling
# ......................................................

module "python_app_autoscale" {
  source                             = "../../../Modules/auto_scaling"
  autoscale_setting_name             = local.python_app_autoscale_name
  resource_group_name                = local.resource_group_name
  location                           = local.location
  target_resource_id                 = module.python_app_service.python_app_service_plan_id
  autoscale_min_capacity             = var.py_autoscale_min_capacity
  autoscale_max_capacity             = var.py_autoscale_max_capacity
  autoscale_default_capacity         = var.py_autoscale_default_capacity
  cpu_metric_threshold_increase      = var.py_cpu_metric_threshold_increase
  cpu_metric_threshold_decrease      = var.py_cpu_metric_threshold_decrease
  increase_scale_action_change_count = var.py_increase_scale_action_change_count
  decrease_scale_action_change_count = var.py_decrease_scale_action_change_count
  scale_action_cooldown              = var.py_scale_action_cooldown
  operator_decrease                  = var.py_operator_decrease
  operator_increase                  = var.py_operator_increase
  cpu_metric_name                    = local.cpu_metric_name
  statistic                          = var.py_statistic
  time_aggregation                   = var.py_time_aggregation
  time_grain                         = var.py_time_grain
  time_window                        = var.py_time_window
  depends_on                         = [module.rg, module.python_app_service]
}