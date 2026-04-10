# ......................................................
# Creating New Resource Group
# ......................................................
module "RG" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.hub_data_rg_name
  resource_group_location = var.location
  resource_group_tags     = var.resource_group_tags
}

# ......................................................
# Creating Key Vault
# ......................................................
module "keyvault" {
  source                        = "../../../Modules/kv/keyvault"
  key_vault_name                = local.key_vault_config.key_vault.kv_name
  location                      = var.location
  resource_group_name           = local.hub_data_rg_name
  sku_name                      = var.key_vault_sku_name
  enabled_for_disk_encryption   = local.key_vault_config.key_vault.enabled_for_disk_encryption
  purge_protection_enabled      = local.key_vault_config.key_vault.purge_protection_enabled
  public_network_access_enabled = local.key_vault_config.key_vault.public_network_access_enabled_kv
  soft_delete_retention_days    = local.key_vault_config.key_vault.soft_delete_retention_days
  tags                          = local.key_vault_config.key_vault.tags
  depends_on                    = [module.RG]
}

# ......................................................
# Creating Private Endpoint for Key Vault
# ......................................................
module "private_endpoint_kv" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.hub_data_rg_name
  location                             = var.location
  private_endpoint_name                = "${local.key_vault_config.key_vault.kv_name}-pep"
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = "${local.key_vault_config.key_vault.kv_name}-psc"
  private_connection_resource_id       = module.keyvault.key_vault_id
  private_connection_subresource_names = local.key_vault_config.key_vault.key_vault_subresource_names
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.key_vault_private_dns_zone_id
  depends_on                           = [module.keyvault]
}

# ......................................................
# Creating Key Vault keys
# ......................................................

# module "kv_keys" {
#   for_each     = local.key_names
#   source       = "../../../Modules/kv/keys"
#   key_name     = each.value
#   key_opts     = var.key_opts
#   key_size     = var.key_size
#   key_type     = var.key_type
#   key_vault_id = module.keyvault.key_vault_id
#   depends_on   = [module.keyvault, module.rg, module.role_assignment_umid, module.role_assignment_user]
# }

# ......................................................
# Creating Key Vault Secret
# ......................................................

# module "kv_secret" {
#   for_each     = { for secret in local.secrets : secret.secret_name => secret }
#   source       = "../../../Modules/kv/secrets"
#   key_vault_id = module.keyvault.key_vault_id
#   secret_name  = each.value.secret_name
#   secret_value = each.value.secret_value
#   depends_on   = [module.keyvault, module.adls, module.cosmos_nosql]
# }

# # ......................................................
# # Creating User Managed Identity
# # ......................................................

# module "user_managed_identity" {
#   source              = "../../../Modules/umid"
#   resource_group_name = local.rg_name
#   location            = var.location
#   umid_name           = local.umid_name
#   depends_on          = [module.rg]
# }


# # ......................................................
# # Creating Private Endpoint for Key Vault
# # ......................................................
# module "private_endpoint_kv" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   private_endpoint_name                = local.kv_pep_name //ict-platform-cog-prd-kv-pep-uaen-01
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = "${local.kv_name}-psc"
#   private_connection_resource_id       = module.keyvault.key_vault_id
#   private_connection_subresource_names = local.key_vault_config.key_vault.key_vault_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.key_vault_private_dns_zone_id
#   depends_on                           = [module.keyvault]
# }

# #......................................................
# # Module: Private Endpoint for speech_service
# #......................................................
# module "private_endpoint_speech_service" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_connection_resource_id       = module.speech_service.cognitive_account_id
#   private_endpoint_name                = local.speech_service_private_endpoint_config.private_endpoint_name
#   private_service_connection_name      = local.speech_service_private_endpoint_config.private_service_connection_name
#   private_dns_zone_group_name          = local.speech_service_private_endpoint_config.private_dns_zone_group_name
#   private_dns_zone_ids                 = local.speech_service_private_endpoint_config.private_dns_zone_ids
#   private_connection_subresource_names = local.speech_service_private_endpoint_config.private_connection_subresource_names
#   is_manual_connection                 = local.speech_service_private_endpoint_config.is_manual_connection
#   depends_on                           = [module.rg, module.speech_service]
# }

# #......................................................
# # Module: Private Endpoint for Language Service.
# #......................................................
# module "private_endpoint_language_service" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_connection_resource_id       = module.language_service.cognitive_account_id
#   private_endpoint_name                = local.language_service_private_endpoint_config.private_endpoint_name
#   private_service_connection_name      = local.language_service_private_endpoint_config.private_service_connection_name
#   private_dns_zone_group_name          = local.language_service_private_endpoint_config.private_dns_zone_group_name
#   private_dns_zone_ids                 = local.language_service_private_endpoint_config.private_dns_zone_ids
#   private_connection_subresource_names = local.language_service_private_endpoint_config.private_connection_subresource_names
#   is_manual_connection                 = local.language_service_private_endpoint_config.is_manual_connection
#   depends_on                           = [module.rg, module.language_service]
# }

# #......................................................
# # Module: Private Endpoint for Translator Service.
# #......................................................
# module "private_endpoint_translator_service" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_connection_resource_id       = module.translator_service.cognitive_account_id
#   private_endpoint_name                = local.translator_service_private_endpoint_config.private_endpoint_name
#   private_service_connection_name      = local.translator_service_private_endpoint_config.private_service_connection_name
#   private_dns_zone_group_name          = local.translator_service_private_endpoint_config.private_dns_zone_group_name
#   private_dns_zone_ids                 = local.translator_service_private_endpoint_config.private_dns_zone_ids
#   private_connection_subresource_names = local.translator_service_private_endpoint_config.private_connection_subresource_names
#   is_manual_connection                 = local.translator_service_private_endpoint_config.is_manual_connection
#   depends_on                           = [module.rg, module.translator_service]
# }

# #......................................................
# # Module: Private Endpoint for Open AI
# #......................................................
# module "private_endpoint_open_ai" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_connection_resource_id       = module.open_ai.openai_id
#   private_endpoint_name                = local.open_ai_private_endpoint_config.private_endpoint_name
#   private_service_connection_name      = local.open_ai_private_endpoint_config.private_service_connection_name
#   private_dns_zone_group_name          = local.open_ai_private_endpoint_config.private_dns_zone_group_name
#   private_dns_zone_ids                 = local.open_ai_private_endpoint_config.private_dns_zone_ids
#   private_connection_subresource_names = local.open_ai_private_endpoint_config.private_connection_subresource_names
#   is_manual_connection                 = local.open_ai_private_endpoint_config.is_manual_connection
#   depends_on                           = [module.rg, module.open_ai]
# }

# #......................................................
# # Module: Private Endpoint for Document Intelligence
# #......................................................
# module "private_endpoint_di" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_endpoint_name                = local.di_pep_name
#   private_service_connection_name      = "${local.document_intelligence_name}-account-psc"
#   private_connection_resource_id       = module.document_intelligence.diId
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.document_intelligence_private_dns_zone_ids
#   private_connection_subresource_names = var.di.pep_target_subresources
#   is_manual_connection                 = local.is_manual_connection
#   depends_on                           = [module.rg, module.document_intelligence]
# }

# #......................................................
# # Module: Private Endpoint for Language Service.
# #......................................................
# module "private_endpoint_ai_search" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_connection_resource_id       = module.ai_search.ai_search_id
#   private_endpoint_name                = local.ai_search_private_endpoint_config.private_endpoint_name
#   private_service_connection_name      = local.ai_search_private_endpoint_config.private_service_connection_name
#   private_dns_zone_group_name          = local.ai_search_private_endpoint_config.private_dns_zone_group_name
#   private_dns_zone_ids                 = local.ai_search_private_endpoint_config.private_dns_zone_ids
#   private_connection_subresource_names = local.ai_search_private_endpoint_config.private_connection_subresource_names
#   is_manual_connection                 = local.ai_search_private_endpoint_config.is_manual_connection
#   depends_on                           = [module.rg, module.ai_search]
# }

# # ......................................................
# # Creating Container Registry Private Endpoint
# # ......................................................
# module "private_endpoint_acr" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   resource_group_name                  = local.resource_group_name
#   location                             = local.location
#   private_endpoint_name                = local.acr_pep_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = "${local.container_registry_name}-psc"
#   private_connection_resource_id       = module.container_registry.id
#   private_connection_subresource_names = local.acr_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.acr_private_dns_zone_id
#   depends_on                           = [module.container_registry]
# }