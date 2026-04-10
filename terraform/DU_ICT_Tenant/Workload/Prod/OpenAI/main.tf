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
# Creating Azure OpenAI
# ......................................................

module "open_ai" {
  source                        = "../../../Modules/openAI"
  Cognitive_account_Name        = local.openAI_account_name
  location                      = local.location
  resource_group_name           = local.resource_group_name
  sku_name                      = var.sku_name
  kind                          = local.kind
  public_network_access_enabled = local.public_network_access_enabled
  custom_subdomain_name         = local.openAI_account_name
  deployment_name               = var.model_name
  ptu_sku_name                  = var.ptu_sku_name
  ptu_sku_capacity              = var.ptu_sku_capacity
  model_format                  = var.model_format
  model_name                    = var.model_name
  model_version                 = var.model_version
  embedding_deployment_name     = var.embedding_deployment_name
  embedding_model_name          = var.embedding_model_name
  embedding_model_version       = var.embedding_model_version
  embedding_sku_capacity        = var.embedding_sku_capacity
  embedding_sku_name            = var.embedding_sku_name
  openai_tags                   = var.openai_tags 
  identity_type                 = var.identity_type
  identity_ids                  = [data.azurerm_user_assigned_identity.uaid.id]
  depends_on                    = [module.rg]
}

# ......................................................
# Creating OpenAI CMK
# ......................................................

module "oai_cmk" {
  source                          = "../../../Modules/cognitive_account_cmk"
  cognitive_account_id            = module.open_ai.openai_id
  key_vault_key_id                = data.azurerm_key_vault_key.aoi_key.id
  user_assigned_identity_clientid = data.azurerm_user_assigned_identity.uaid.client_id
}

# # ......................................................
# # Creating Private Endpoint for OpenAI
# # ......................................................

# module "private_endpoint_openai" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   resource_group_name                  = local.resource_group_name
#   location                             = local.location
#   private_endpoint_name                = local.openai_private_endpoint_name
#   subnet_endpoint_id                   = module.subnet.subnet_id
#   private_service_connection_name      = local.private_service_connection_name
#   private_connection_resource_id       = module.open_ai.openai_id
#   private_connection_subresource_names = local.openai_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.openai_private_dns_zone_id
#   depends_on                           = [module.open_ai, module.rg]
# }

# ......................................................
# Creating Diagnostic settings for Open AI
# ......................................................

module "diagnostic_setting_openai" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_openai_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = module.open_ai.openai_id
  enabled_log                = local.enabled_logs_openai
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.open_ai]
}
