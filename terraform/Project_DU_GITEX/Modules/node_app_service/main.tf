resource "azurerm_service_plan" "node_app_service_plan" {
  name                = var.node_app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.node_app_service_plan_sku
  os_type             = var.node_app_service_plan_os_type
}

resource "azurerm_windows_web_app" "node_app_service" {
  name                          = var.node_app_service_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = azurerm_service_plan.node_app_service_plan.id
  virtual_network_subnet_id     = var.node_app_subnet_id
  public_network_access_enabled = var.public_network_access_enabled
  https_only                    = var.https_only

  app_settings = {
    WEBSITE_NODE_DEFAULT_VERSION                      = var.node_version
    WEBSITE_STACK                                     = var.current_stack
    APPINSIGHTS_INSTRUMENTATIONKEY                    = var.application_insights_instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING             = var.application_insights_connection_string
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = var.appinsights_profilerfeature_version
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = var.appinsights_snapshotfeature_version
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = var.applicationinsightsagent_extension_version
    "DiagnosticServices_EXTENSION_VERSION"            = var.diagnosticservices_extension_version
    "InstrumentationEngine_EXTENSION_VERSION"         = var.instrumentationengine_extension_version
    "SnapshotDebugger_EXTENSION_VERSION"              = var.snapshotdebugger_extension_version
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = var.xdt_microsoftapplicationinsights_baseextensions
    "XDT_MicrosoftApplicationInsights_Mode"           = var.xdt_microsoftapplicationinsights_mode
     REACT_APP_API_URL = var.REACT_APP_API_URL
  }

  site_config {
    application_stack {
      current_stack = var.current_stack
      node_version  = var.node_version
    }
    vnet_route_all_enabled = var.vnet_route_all_enabled
    minimum_tls_version    = var.minimum_tls_version
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }

  lifecycle {
    ignore_changes = all
  }

  tags = var.tags
}
