locals {

  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  ai_rg_name                         = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-ai-rg"
  ai_search_service_name             = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-srch"
  document_intelligence_account_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-di"

  document_intelligence_kind = "FormRecognizer"

  local_authentication_enabled                        = true
  public_network_access_enabled_ai_search             = false
  public_network_access_enabled_document_intelligence = false

  key_vault_key_id = ""

  ai_search_private_endpoint_name     = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-srch-pep"
  document_intelligence_endpoint_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-di-pep"

  private_dns_zone_group_name     = "default"
  private_service_connection_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pep-connection"

  ai_search_subresource_names        = ["searchService"]
  cognitive_account_subresource_name = ["account"]

  is_manual_connection = false
}
