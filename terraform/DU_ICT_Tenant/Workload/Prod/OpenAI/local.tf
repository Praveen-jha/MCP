locals {

  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  ai_rg_name           = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-rg"
  openAI_account_name  = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-oai"

  diagnostic_setting_openai_name  = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-oai-diagnostics"

  kind = "OpenAI"

  public_network_access_enabled = true

  enabled_logs_openai = {
    category        = [],
    category_groups = ["allLogs"]
  }
  metrics = ["AllMetrics"]

}
