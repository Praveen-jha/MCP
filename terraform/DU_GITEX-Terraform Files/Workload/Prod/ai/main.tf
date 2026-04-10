# ......................................................
# Creating New Resource Group
# ......................................................

module "rg" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.ai_rg_name
  resource_group_location = var.ai_rg_location
}

# ...................................................... 
# Creating Azure AI Search Service
# ......................................................

module "ai_search" {
  source                        = "../../../Modules/aiSearch"
  search_service_name           = local.ai_search_service_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  sku                           = var.ai_search_sku
  local_authentication_enabled  = local.local_authentication_enabled
  authentication_failure_mode   = var.authentication_failure_mode
  public_network_access_enabled = local.public_network_access_enabled_ai_search
  identity_type                 = var.identity_type
  identity_ids                  = [data.azurerm_user_assigned_identity.uaid.id]
  depends_on                    = [module.rg]
  tags                          = var.ai_search_tags
}

# ......................................................
# Creating Document Intelligence
# ......................................................

module "document_intelligence" {
  source                        = "../../../Modules/cognitiveAccount"
  account_name                  = local.document_intelligence_account_name
  location                      = local.location
  resource_group_name           = local.resource_group_name
  kind                          = local.document_intelligence_kind
  sku_name                      = var.document_intelligence_sku_name
  local_auth_enabled            = local.local_authentication_enabled
  public_network_access_enabled = local.public_network_access_enabled_document_intelligence
  identity_type                 = var.identity_type
  identity_ids                  = [data.azurerm_user_assigned_identity.uaid.id]
  key_vault_key_id              = local.key_vault_key_id
  custom_subdomain_name         = local.document_intelligence_account_name
  depends_on                    = [module.rg]
  tags                          = var.document_intelligence_tags
}
# ......................................................
# Creating New Translator Service
# ......................................................

module "translator_service" {
  source                        = "../../../Modules/cognitiveAccount"
  account_name                  = local.translator_service_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  custom_subdomain_name         = local.translator_service_name
  public_network_access_enabled = local.public_network_access_enabled_translator_service
  sku_name                      = var.translator_service_sku
  kind                          = local.translator_service_kind
  key_vault_key_id              = local.key_vault_key_id
  identity_type                 = var.identity_type
  depends_on                    = [module.rg]
  tags                          = var.translator_tags
  local_auth_enabled            = local.local_authentication_enabled
  identity_ids                  = [data.azurerm_user_assigned_identity.uaid.id]
}


# ......................................................
# Creating Speech Service
# ......................................................

module "speech_service" {
  source                        = "../../../Modules/cognitiveAccount"
  account_name                  = local.speech_service_name
  resource_group_name           = local.resource_group_name
  location                      = var.speech_rg_location
  custom_subdomain_name         = local.speech_service_name
  public_network_access_enabled = local.public_network_access_enabled_speech_service
  sku_name                      = var.speech_service_sku 
  kind                          = local.speech_service_kind
  key_vault_key_id              = local.key_vault_key_id
  identity_type                 = var.identity_type
  depends_on                    = [module.rg]
  tags                          = var.speech_service_tags
  local_auth_enabled            = local.local_authentication_enabled
  identity_ids                  = [data.azurerm_user_assigned_identity.uaid.id]
}

# ......................................................
# Creating Document Intelligence CMK
# ......................................................

module "di_cmk" {
  source                          = "../../../Modules/cognitive_account_cmk"
  cognitive_account_id            = module.document_intelligence.cognitive_account_id
  key_vault_key_id                = data.azurerm_key_vault_key.key[0].id
  user_assigned_identity_clientid = data.azurerm_user_assigned_identity.uaid.client_id
}

# ......................................................
# Creating translator_service  CMK
# ......................................................

module "trsl_cmk" {
  source                          = "../../../Modules/cognitive_account_cmk"
  cognitive_account_id            = module.translator_service.cognitive_account_id
  key_vault_key_id                = data.azurerm_key_vault_key.key[1].id
  user_assigned_identity_clientid = data.azurerm_user_assigned_identity.uaid.client_id
  depends_on                      = [module.translator_service]
}

# ......................................................
# Enable diagnostic setting for document intelligence
# ......................................................

module "diagnostic_setting_document_intelligence" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_di_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = module.document_intelligence.cognitive_account_id
  enabled_log                = local.enabled_logs
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.document_intelligence]
}

# ......................................................
# Enable diagnostic setting for ai search
# ......................................................

module "diagnostic_setting_ai_search" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_ai_search_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = module.ai_search.ai_search_id
  enabled_log                = local.enabled_logs
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.ai_search]
}

# ......................................................
# Enable diagnostic setting for translator service
# ......................................................

module "diagnostic_setting_translator_service" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_trsl_name 
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = module.translator_service.cognitive_account_id
  enabled_log                = local.enabled_logs
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.translator_service]
}

# ......................................................
# Enable diagnostic setting for speech service
# ......................................................

module "diagnostic_setting_speech_service" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_spch_name 
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = module.speech_service.cognitive_account_id
  enabled_log                = local.enabled_logs
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.speech_service]
}

# ......................................................
# Creating Private Endpoint for AI Search
# ......................................................

module "private_endpoint_aisearch" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.ai_search_private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.ai_search.ai_search_id
  private_connection_subresource_names = local.ai_search_subresource_names
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.ai_search_private_dns_zone_id
  depends_on                           = [module.ai_search]
}

# ......................................................
# Creating Private Endpoint for Document Intelligence
# ......................................................

module "private_endpoint_di" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.document_intelligence_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.document_intelligence.cognitive_account_id
  private_connection_subresource_names = local.cognitive_account_subresource_name
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.cognitive_account_private_dns_zone_id
  depends_on                           = [module.document_intelligence, module.di_cmk]
}


# ......................................................
# Creating Private Endpoint for Translator
# ......................................................
module "private_endpoint_translator" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.translator_service_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.translator_service.cognitive_account_id
  private_connection_subresource_names = local.cognitive_account_subresource_name
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.cognitive_account_private_dns_zone_id
  depends_on                           = [module.translator_service]
}
