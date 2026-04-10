locals {
  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  app_rg_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-app-rg"

  node_app_service_plan_name   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-node-app-asp"
  node_app_service_name        = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-node-app"
  python_app_service_plan_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-py-app-asp"
  python_app_service_name      = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-py-app"
  application_insights         = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-appi"

  budgetName = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-budget"

  node_app_vnet_integration = null

  node_app_autoscale_name   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-node-app-asp-auto-scale"
  python_app_autoscale_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-py-app-asp-auto-scale"
  cpu_metric_name           = "CpuPercentage"

  public_network_access_enabled_python_as = true
  public_network_access_enabled_node_as   = true

  diagnostic_setting_py_app_name   = "${var.tenant_name}-platform-hrbot-${var.environment}-py-app-diagnostics"
  diagnostic_setting_node_app_name = "${var.tenant_name}-platform-hrbot-${var.environment}-node-app-diagnostics"

  action_group_name          = "${var.tenant_name}-platform-hrbot-${var.environment}-action-group"
  action_group_shortname     = "AppServiceAG"
  metric_alert_frontend_name = "${var.tenant_name}-platform-hrbot-${var.environment}-node-app-alert"
  metric_alert_backend_name  = "${var.tenant_name}-platform-hrbot-${var.environment}-py-app-alert"

  alert_frontend_description = "Bot Frontend App Service is Down"
  alert_backend_description  = "Bot Backend App Service is Down"

  email_receivers = [
    {
      name          = "Vishal Choudhary"
      email_address = "vishal.choudhary@celebaltech.com"
    },
    {
      name          = "Narendranath Thota"
      email_address = "Narendranath.Thota@du.ae"
    },
    {
      name          = "Pranshul Jain"
      email_address = "Pranshul.Jain@du.ae"
    }
  ]

  notification = {
    alert1 = {
      enabled        = true
      operator       = "GreaterThan"
      threshold      = 75
      thresholdType  = "Actual"
      contact_emails = ["vishal.choudhary@celebaltech.com", "Narendranath.Thota@du.ae"]
    },
    alert2 = {
      enabled        = true
      operator       = "GreaterThan"
      threshold      = 90
      thresholdType  = "Actual"
      contact_emails = ["vishal.choudhary@celebaltech.com", "Narendranath.Thota@du.ae"]
    }
  }

  criteria_config = [
    {
      metric_namespace       = "Microsoft.Web/sites"
      metric_name            = "Http4xx"
      aggregation            = "Total"
      operator               = "GreaterThan"
      threshold              = 0
      skip_metric_validation = false
    },
    {
      metric_namespace       = "Microsoft.Web/sites"
      metric_name            = "Http5xx"
      aggregation            = "Average"
      operator               = "GreaterThan"
      threshold              = 0
      skip_metric_validation = true
    }
  ]

  # is_manual_connection   = false
  vnet_route_all_enabled = true

  enabled_logs_py_app = {
    category        = ["AppServiceAntivirusScanAuditLogs", "AppServiceHTTPLogs", "AppServiceConsoleLogs", "AppServiceAppLogs", "AppServiceFileAuditLogs", "AppServiceAuditLogs", "AppServiceIPSecAuditLogs", "AppServicePlatformLogs", "AppServiceAuthenticationLogs"],
    category_groups = []
  }
  enabled_logs_node_app = {
    category        = ["AppServiceHTTPLogs", "AppServiceConsoleLogs", "AppServiceAppLogs", "AppServiceAuditLogs", "AppServiceIPSecAuditLogs", "AppServicePlatformLogs", "AppServiceAuthenticationLogs"],
    category_groups = []
  }
  metrics = ["AllMetrics"]
}
