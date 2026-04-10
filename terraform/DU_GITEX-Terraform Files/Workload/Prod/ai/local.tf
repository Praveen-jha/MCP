locals {

  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  ai_rg_name                         = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-ai-rg"
  ai_search_service_name             = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-srch"
  document_intelligence_account_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-di"
  translator_service_name            = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-trsl"
  speech_service_name               = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-spch"
  diagnostic_setting_di_name         = "${var.tenant_name}-platform-gitex-${var.environment}-di-diagnostics"
  diagnostic_setting_ai_search_name  = "${var.tenant_name}-platform-gitex-${var.environment}-ai-search-diagnostics"
  diagnostic_setting_trsl_name       = "${var.tenant_name}-platform-gitex-${var.environment}-trsl-diagnostics"
  diagnostic_setting_spch_name       = "${var.tenant_name}-platform-gitex-${var.environment}-spch-diagnostics"

  document_intelligence_kind = "FormRecognizer"
  translator_service_kind    = "TextTranslation"
  speech_service_kind        = "SpeechServices"
  key_vault_key_id           = ""

  local_authentication_enabled                        = true
  public_network_access_enabled_ai_search             = false
  public_network_access_enabled_document_intelligence = false
  public_network_access_enabled_translator_service    = false
  public_network_access_enabled_speech_service        = true

  ai_search_private_endpoint_name     = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-srch-pep"
  document_intelligence_endpoint_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-di-pep"
  translator_service_endpoint_name    = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-trsl-pep"

  private_dns_zone_group_name     = "default"
  private_service_connection_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pep-connection"

  ai_search_subresource_names        = ["searchService"]
  cognitive_account_subresource_name = ["account"]

  enabled_logs = {
    category        = [],
    category_groups = ["allLogs"]
  }
  metrics = ["AllMetrics"]

  is_manual_connection = false
}
