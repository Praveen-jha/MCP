# --- Diagnostic and Logging Configuration ---
# Link APIM to Application Insights for request tracing
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger
resource "azurerm_api_management_logger" "appinsights" {
  count               = var.app_insight_enabled ? 1 : 0
  name                = "apimlog_${var.name}" # e.g., "apiml-myapim"
  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name

  # Use the App Insights instance (either new or existing)
  application_insights {
    instrumentation_key = var.application_insights_name != "" ? data.azurerm_application_insights.existing[0].instrumentation_key : azurerm_application_insights.new[0].instrumentation_key
  }
}

