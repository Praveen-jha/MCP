resource "azurerm_service_plan" "python_app_service_plan" {
  name                = var.python_app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.python_app_service_plan_sku
  os_type             = var.python_app_service_plan_os_type
}

resource "azurerm_linux_web_app" "python_app_service" {
  name                          = var.python_app_service_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = azurerm_service_plan.python_app_service_plan.id
  virtual_network_subnet_id     = var.python_app_subnet_id
  public_network_access_enabled = var.public_network_access_enabled
  https_only                    = var.https_only

  site_config {
    application_stack {
      python_version = var.python_version
    }
    minimum_tls_version    = var.minimum_tls_version
    vnet_route_all_enabled = var.vnet_route_all_enabled
    
  }
  app_settings = {
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
    SCM_DO_BUILD_DURING_DEPLOYMENT                    = var.SCM_DO_BUILD_DURING_DEPLOYMENT
    OPENAI_API_KEY                                    = var.OPENAI_API_KEY
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }

  # lifecycle {
  #   ignore_changes = all
  # }

  tags = var.tags

}
