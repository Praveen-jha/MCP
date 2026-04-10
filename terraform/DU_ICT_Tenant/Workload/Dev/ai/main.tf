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
# Creating Azure AI Bot
# ......................................................

module "bot_service" {
  source                        = "../../../Modules/botService/bot"
  bot_name                      = local.ai_bot_name
  resource_group_name           = local.resource_group_name
  location                      = local.bot_service_location
  microsoft_app_id              = var.application_id
  sku                           = var.ai_bot_sku
  public_network_access_enabled = local.public_network_access_enabled_bot_service
  local_authentication_enabled  = local.local_authentication_enabled
  endpoint                      = var.endpoint
  depends_on                    = [module.rg]
  tags                          = var.bot_service_tags
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
  depends_on                           = [module.document_intelligence]
}
