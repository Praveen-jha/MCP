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
# Creating Key Vault
# ......................................................
module "keyvault" {
  source                        = "../../../Modules/kv/keyvault"
  key_vault_name                = local.kv_name
  location                      = local.location
  resource_group_name           = local.resource_group_name
  sku_name                      = var.key_vault_sku_name
  enabled_for_disk_encryption   = local.enabled_for_disk_encryption
  purge_protection_enabled      = local.purge_protection_enabled
  public_network_access_enabled = local.public_network_access_enabled_kv
  soft_delete_retention_days    = local.soft_delete_retention_days
  depends_on                    = [module.rg]
}

# ......................................................
# Creating Key Vault
# ......................................................
module "kv_keys" {
  count        = length(local.key_names)
  source       = "../../../Modules/kv/keys"
  key_name     = element(local.key_names, count.index)
  key_opts     = var.key_opts
  key_size     = var.key_size
  key_type     = var.key_type
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.keyvault, module.rg, module.role_assignment_user]
}

# ......................................................
# Creating Key Vault Secret
# ......................................................
module "kv_secret" {
  for_each     = { for secret in local.secrets : secret.secret_name => secret }
  source       = "../../../Modules/kv/secrets"
  key_vault_id = module.keyvault.key_vault_id
  secret_name  = each.value.secret_name
  secret_value = each.value.secret_value
  depends_on   = [module.keyvault, module.document_intelligence]
}

# # ......................................................
# # Creating Private Endpoint for Key Vault
# # ......................................................
module "hub_private_endpoint_key_vault" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_connection_resource_id       = module.keyvault.key_vault_id
  private_endpoint_name                = local.hub_key_vault_private_endpoint_config.private_endpoint_name
  private_service_connection_name      = local.hub_key_vault_private_endpoint_config.private_service_connection_name
  private_dns_zone_group_name          = local.hub_key_vault_private_endpoint_config.private_dns_zone_group_name
  private_dns_zone_ids                 = local.hub_key_vault_private_endpoint_config.private_dns_zone_ids
  private_connection_subresource_names = local.hub_key_vault_private_endpoint_config.private_connection_subresource_names
  is_manual_connection                 = local.hub_key_vault_private_endpoint_config.is_manual_connection
  depends_on                           = [module.rg, module.keyvault]
}

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

# ......................................................
# Creating User Managed Identity
# ......................................................
module "user_managed_identity" {
  source              = "../../../Modules/umid"
  resource_group_name = local.resource_group_name
  location            = local.location
  umid_name           = local.umid_name
  depends_on          = [module.rg]
}

# ......................................................
# Creating Role(Key Vault Crypto Officer) Assignment UMID
# ......................................................
module "role_assignment_umid" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_role_definition_name
  scope                = module.keyvault.key_vault_id
  principal_id         = module.user_managed_identity.umid_principal_id
  depends_on           = [module.rg, module.keyvault, module.user_managed_identity]
}

# ......................................................
# Creating Role(Key Vault Crypto Officer) Assignment Service Principal
# ......................................................
module "role_assignment_user" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_role_definition_name
  scope                = module.keyvault.key_vault_id
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on           = [module.rg, module.keyvault]
}

# ......................................................
# Creating Role(key vault secrets officer) Assignment Service Principal
# ......................................................
module "role_assignment_user02" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_role_secrets_definition_name
  scope                = module.keyvault.key_vault_id
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on           = [module.rg, module.keyvault]
}

# ......................................................
# Creating New Speech Service
# ......................................................
module "speech_service" {
  source                          = "../../../Modules/cognitiveAccount"
  account_name                    = local.speech_service_name
  resource_group_name             = local.resource_group_name
  location                        = local.location
  custom_subdomain_name           = local.speech_service_name
  public_network_access_enabled   = local.public_network_access_enabled
  sku_name                        = var.speech_service_sku
  kind                            = local.speech_service_kind
  user_assigned_identity_id       = [module.user_managed_identity.umid]
  user_assigned_identity_clientid = module.user_managed_identity.umid_client_id
  key_vault_key_id                = module.kv_keys[0].key_vault_key_id
  identity_type                   = var.identity_type
  depends_on                      = [module.rg, module.user_managed_identity, module.kv_keys, module.role_assignment_umid]
}

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

module "hub_private_endpoint_speech_service" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_connection_resource_id       = module.speech_service.cognitive_account_id
  private_endpoint_name                = local.hub_speech_service_private_endpoint_config.private_endpoint_name
  private_service_connection_name      = local.hub_speech_service_private_endpoint_config.private_service_connection_name
  private_dns_zone_group_name          = local.hub_speech_service_private_endpoint_config.private_dns_zone_group_name
  private_dns_zone_ids                 = local.hub_speech_service_private_endpoint_config.private_dns_zone_ids
  private_connection_subresource_names = local.hub_speech_service_private_endpoint_config.private_connection_subresource_names
  is_manual_connection                 = local.hub_speech_service_private_endpoint_config.is_manual_connection
  depends_on                           = [module.rg, module.speech_service]
}

# ......................................................
# Creating diagnostic settings for speech service
# ......................................................
module "speech_service_ds" {
  source                     = "../../../Modules/monitoring/diagnosticSettings"
  diagnostic_setting_name    = local.spch_diagnostic_setting_name
  target_resource_id         = module.speech_service.cognitive_account_id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  enabled_log                = local.spch_log_category
  metric                     = coalesce(local.spch_metrics, [""])
  depends_on                 = [module.speech_service]
}

# ......................................................
# Creating New Language Service
# ......................................................
module "language_service" {
  source                          = "../../../Modules/cognitiveAccount"
  account_name                    = local.language_service_name
  resource_group_name             = local.resource_group_name
  location                        = local.location
  custom_subdomain_name           = local.language_service_name
  public_network_access_enabled   = local.public_network_access_enabled
  sku_name                        = var.language_service_sku
  kind                            = local.language_service_kind
  user_assigned_identity_id       = [module.user_managed_identity.umid]
  user_assigned_identity_clientid = module.user_managed_identity.umid_client_id
  key_vault_key_id                = module.kv_keys[1].key_vault_key_id
  identity_type                   = var.identity_type
  depends_on                      = [module.rg, module.user_managed_identity, module.kv_keys, module.role_assignment_umid]
}

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

module "hub_private_endpoint_language_service" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_connection_resource_id       = module.language_service.cognitive_account_id
  private_endpoint_name                = local.hub_language_service_private_endpoint_config.private_endpoint_name
  private_service_connection_name      = local.hub_language_service_private_endpoint_config.private_service_connection_name
  private_dns_zone_group_name          = local.hub_language_service_private_endpoint_config.private_dns_zone_group_name
  private_dns_zone_ids                 = local.hub_language_service_private_endpoint_config.private_dns_zone_ids
  private_connection_subresource_names = local.hub_language_service_private_endpoint_config.private_connection_subresource_names
  is_manual_connection                 = local.hub_language_service_private_endpoint_config.is_manual_connection
  depends_on                           = [module.rg, module.language_service]
}


# ......................................................
# Creating diagnostic settings for language service
# ......................................................
module "language_service_ds" {
  source                     = "../../../Modules/monitoring/diagnosticSettings"
  diagnostic_setting_name    = local.lang_diagnostic_setting_name
  target_resource_id         = module.language_service.cognitive_account_id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  enabled_log                = local.lang_log_category
  metric                     = coalesce(local.lang_metrics, [""])
  depends_on                 = [module.language_service]
}

# ......................................................
# Creating New Translator Service
# ......................................................
module "translator_service" {
  source                          = "../../../Modules/cognitiveAccount"
  account_name                    = local.translator_service_name
  resource_group_name             = local.resource_group_name
  location                        = local.location
  custom_subdomain_name           = local.translator_service_name
  public_network_access_enabled   = local.public_network_access_enabled
  sku_name                        = var.translator_service_sku
  kind                            = local.translator_service_kind
  user_assigned_identity_id       = [module.user_managed_identity.umid]
  user_assigned_identity_clientid = module.user_managed_identity.umid_client_id
  key_vault_key_id                = module.kv_keys[2].key_vault_key_id
  identity_type                   = var.identity_type
  depends_on                      = [module.rg, module.user_managed_identity, module.kv_keys, module.role_assignment_umid]
}

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

module "hub_private_endpoint_translator_service" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_connection_resource_id       = module.translator_service.cognitive_account_id
  private_endpoint_name                = local.hub_translator_service_private_endpoint_config.private_endpoint_name
  private_service_connection_name      = local.hub_translator_service_private_endpoint_config.private_service_connection_name
  private_dns_zone_group_name          = local.hub_translator_service_private_endpoint_config.private_dns_zone_group_name
  private_dns_zone_ids                 = local.hub_translator_service_private_endpoint_config.private_dns_zone_ids
  private_connection_subresource_names = local.hub_translator_service_private_endpoint_config.private_connection_subresource_names
  is_manual_connection                 = local.hub_translator_service_private_endpoint_config.is_manual_connection
  depends_on                           = [module.rg, module.translator_service]
}

# ......................................................
# Creating diagnostic settings for translator service
# ......................................................
module "translator_service_ds" {
  source                     = "../../../Modules/monitoring/diagnosticSettings"
  diagnostic_setting_name    = local.trsl_diagnostic_setting_name
  target_resource_id         = module.translator_service.cognitive_account_id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  enabled_log                = local.trsl_log_category
  metric                     = coalesce(local.trsl_metrics, [""])
  depends_on                 = [module.translator_service]
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
  # #latest 
  # latest_deployment_name  = var.latest_deployment_name 
  # latest_ptu_sku_name     = var.latest_ptu_sku_name
  # latest_ptu_sku_capacity = var.latest_ptu_sku_capacity
  # latest_model_format     = var.latest_model_format
  # latest_model_name       = var.latest_model_name
  # latest_model_version    = var.latest_model_version

  user_assigned_identity_id       = [module.user_managed_identity.umid]
  user_assigned_identity_clientid = module.user_managed_identity.umid_client_id
  key_vault_key_id                = module.kv_keys[3].key_vault_key_id
  identity_type                   = var.identity_type
  embedding_deployment_name       = var.embedding_deployment_name
  embedding_model_name            = var.embedding_model_name
  embedding_model_version         = var.embedding_model_version
  embedding_sku_capacity          = var.embedding_sku_capacity
  embedding_sku_name              = var.embedding_sku_name
  depends_on                      = [module.rg, module.user_managed_identity, module.kv_keys, module.role_assignment_umid]
}

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

module "hub_private_endpoint_open_ai" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_connection_resource_id       = module.open_ai.openai_id
  private_endpoint_name                = local.hub_open_ai_private_endpoint_config.private_endpoint_name
  private_service_connection_name      = local.hub_open_ai_private_endpoint_config.private_service_connection_name
  private_dns_zone_group_name          = local.hub_open_ai_private_endpoint_config.private_dns_zone_group_name
  private_dns_zone_ids                 = local.hub_open_ai_private_endpoint_config.private_dns_zone_ids
  private_connection_subresource_names = local.hub_open_ai_private_endpoint_config.private_connection_subresource_names
  is_manual_connection                 = local.hub_open_ai_private_endpoint_config.is_manual_connection
  depends_on                           = [module.rg, module.open_ai]
}

# ......................................................
# Creating diagnostic settings for Azure OpenAI
# ......................................................
module "open_ai_ds" {
  source                     = "../../../Modules/monitoring/diagnosticSettings"
  diagnostic_setting_name    = local.oai_diagnostic_setting_name
  target_resource_id         = module.open_ai.openai_id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  enabled_log                = local.oai_log_category
  metric                     = coalesce(local.oai_metrics, [""])
  depends_on                 = [module.open_ai]
}

# # ......................................................
# # Creating Role Assignment Contributor
# # ......................................................
# module "role_assignment_contributor" {
#   source               = "../../../Modules/roleAssignment"
#   role_definition_name = local.contributor_role_definition_name
#   scope                = "/subscriptions/b092ed20-9480-45e1-a96c-8b307bfa9eab"
#   principal_id         = local.contributor_principal_id
#   depends_on           = [module.rg]
# }

# ......................................................
# Module: Document Intelligence(di)
# ......................................................
module "document_intelligence" {
  source                      = "../../../Modules/documentIntelligence"
  document_intelligence_name  = local.document_intelligence_name
  location                    = local.location
  rgName                      = local.resource_group_name
  diSkuName                   = var.di.di_skuname
  identityType                = var.di.identity_type
  publiceNetworkAccessEnabled = var.di.public_network_access_enabled_di
  diCustomSubdomain           = local.document_intelligence_name
  diKind                      = var.di.di_kind
  key_vault_key_id            = module.kv_keys[4].key_vault_key_id
  user_assigned_identity_id   = module.user_managed_identity.umid_client_id
  identity_ids                = [module.user_managed_identity.umid]
  diTags                      = merge(var.tags, var.di.di_tags)
  depends_on                  = [module.rg, module.kv_keys]
}

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

module "hub_private_endpoint_di" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_endpoint_name                = local.hub_di_pep_name
  private_service_connection_name      = "${local.document_intelligence_name}-account-psc"
  private_connection_resource_id       = module.document_intelligence.diId
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.document_intelligence_private_dns_zone_ids
  private_connection_subresource_names = var.di.pep_target_subresources
  is_manual_connection                 = local.is_manual_connection
  depends_on                           = [module.rg, module.document_intelligence]
}

# ......................................................
# Creating Azure ML
# ......................................................
# module "ml_workspace" {
#   source                           = "../../../Modules/machineLearning"
#   ml_workspace_name                = local.ml_workspace_config.ml_workspace.ml_workspace_name
#   resource_group_name              = local.resource_group_name
#   location                         = local.location
#   ml_workspace_identity_type       = local.ml_workspace_config.ml_workspace.ml_workspace_identity_type
#   ml_workspace_identity_id         = [module.user_managed_identity.umid]
#   key_vault_id                     = module.keyvault.key_vault_id
#   isolation_mode_ml                = local.ml_workspace_config.ml_workspace.isolation_mode_ml
#   application_insights_id          = module.application_insights_ml.application_insights_id
#   public_network_access_enabled_ml = local.ml_workspace_config.ml_workspace.public_network_access_enabled_ml
#   storage_account_id               = module.adls.ml_storage.storage_account_id
#   user_assigned_identity_id        = module.user_managed_identity.umid
#   tags                             = local.ml_workspace_config.ml_workspace.tags
#   depends_on                       = [module.adls, module.application_insights_ml, module.user_managed_identity, module.keyvault]
# }

# ......................................................
# Creating Private Endpoint for Azure ML amlworkspace
# ......................................................
# module "private_endpoint_ml" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   resource_group_name                  = local.resource_group_name
#   location                             = local.location
#   private_endpoint_name                = "${local.ml_workspace_config.ml_workspace.ml_workspace_name}-amlworkspace-pep"
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = "${local.ml_workspace_config.ml_workspace.ml_workspace_name}-amlworkspace-psc"
#   private_connection_resource_id       = module.ml_workspace.ml_workspace_id
#   private_connection_subresource_names = local.ml_workspace_config.ml_workspace.private_connection_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.ml_workspace_private_dns_zone_id
#   depends_on                           = [module.ml_workspace]
# }

# ......................................................
# Creating compute instance for Azure ML workspace
# ......................................................
# module "ml_compute" {
#   source                        = "../../../Modules/mlComputeInstance"
#   for_each                      = local.ml_vm_configs
#   ml_compute_instance_name      = each.value
#   ml_compute_vm_size            = var.ml_vm_configs[each.key].ml_compute_vm_size
#   node_public_ip_enabled        = var.ml_vm_configs[each.key].node_public_ip_enabled
#   ml_compute_tags               = var.ml_vm_configs[each.key].ml_compute_tags
#   object_id_user                = var.ml_vm_configs[each.key].object_id_user
#   tenant_id                     = var.ml_vm_configs[each.key].tenant_id
#   subnet_resource_id            = data.azurerm_subnet.ml_compute_instance_subnet.id
#   machine_learning_workspace_id = module.ml_workspace.ml_workspace_id
#   depends_on                    = [module.ml_workspace, module.private_endpoint_ml]
# }

# ......................................................
# Creating compute instance for Azure ML workspace
# ......................................................
# module "application_insights_ml" {
#   source                     = "../../../Modules/applicationInsights"
#   name                       = local.application_insights_config.ml_workspace.name
#   resource_group_name        = local.resource_group_name
#   location                   = local.location
#   application_type           = local.application_insights_config.ml_workspace.application_type
#   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
#   depends_on                 = [module.rg]
# }

# ......................................................
# Creating Storage Accounts
# ......................................................
# module "adls" {
#   source                        = "../../../Modules/adls/storageAccount"
#   for_each                      = local.storage_accounts
#   storage_account_name          = lower(each.value.storage_account_name)
#   resource_group_name           = local.resource_group_name
#   location                      = local.location
#   storage_account_tier          = each.value.storage_account_tier
#   account_replication_type      = each.value.account_replication_type
#   is_hns_enabled                = each.value.is_hns_enabled
#   storage_identity_type         = each.value.storage_identity_type
#   storage_identity_id           = [module.user_managed_identity.umid]
#   public_network_access_enabled = each.value.public_network_access_enabled_adls
#   tags                          = each.value.tags
#   depends_on                    = [module.rg, module.user_managed_identity]
# }

# ......................................................
# Enable Storage Accounts CMK(Customer Managed key)
# ......................................................
# module "adls_cmk" {
#   for_each                        = local.storage_accounts
#   source                          = "../../../Modules/adls/storageCMK"
#   storage_account_id              = module.adls[each.key].storage_account_id
#   key_vault_id                    = module.keyvault.key_vault_id
#   key_name                        = each.value.key_name_cmk
#   user_assigned_identity_clientid = module.user_managed_identity.umid_client_id
#   user_assigned_identity_id       = module.user_managed_identity.umid
#   depends_on                      = [module.rg, module.adls, module.kv_keys]
# }

# ......................................................
# Creating diagnostic settings for storage accounts
# ......................................................
# module "storage_account_ds" {
#   source                     = "../../../Modules/monitoring/diagnosticSettings"
#   for_each                   = local.storage_accounts
#   diagnostic_setting_name    = "${each.value.storage_account_name}DiagToLAWorkspace"
#   target_resource_id         = module.adls[each.key].storage_account_id
#   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
#   enabled_log                = local.log_category
#   metric                     = coalesce(local.metrics, [""])
#   depends_on                 = [module.adls]
# }

# ......................................................
# Creating Role Assignment UMID of Storage_contributor
# ......................................................
# module "role_assignment_umid_storage_contributor" {
#   source               = "../../../Modules/roleAssignment"
#   role_definition_name = local.storage_role_definition_name
#   scope                = module.adls.ml_storage.storage_account_id
#   principal_id         = module.user_managed_identity.umid_principal_id
#   depends_on           = [module.rg, module.user_managed_identity, module.adls]
# }

# ......................................................
# Creating Storage Accounts Blob Private Endpoint
# ......................................................
# module "private_endpoint_blob" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   for_each                             = local.storage_accounts
#   resource_group_name                  = local.resource_group_name
#   location                             = local.location
#   private_endpoint_name                = "${each.value.storage_account_name}-blob-pep"
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = "${each.value.storage_account_name}-blob-psc"
#   private_connection_resource_id       = module.adls[each.key].storage_account_id
#   private_connection_subresource_names = local.adls_blob_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.adls_blob_private_dns_zone_id
#   depends_on                           = [module.adls]
# }

# ......................................................
# Creating Storage Accounts File Private Endpoint
# ......................................................
# module "private_endpoint_file" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   for_each                             = { for key, value in local.storage_accounts : key => value if contains(value.endpoint, "file") }
#   resource_group_name                  = local.resource_group_name
#   location                             = local.location
#   private_endpoint_name                = "${each.value.storage_account_name}-file-pep"
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = "${each.value.storage_account_name}-file-psc"
#   private_connection_resource_id       = module.adls[each.key].storage_account_id
#   private_connection_subresource_names = local.adls_file_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.adls_file_private_dns_zone_id
#   depends_on                           = [module.adls]
# }

# ......................................................
# Creating Storage Accounts dfs Private Endpoint
# ......................................................
# module "private_endpoint_dfs" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   for_each                             = { for key, value in local.storage_accounts : key => value if contains(value.endpoint, "dfs") }
#   resource_group_name                  = local.resource_group_name
#   location                             = local.location
#   private_endpoint_name                = "${each.value.storage_account_name}-dfs-pep"
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = "${each.value.storage_account_name}-dfs-psc"
#   private_connection_resource_id       = module.adls[each.key].storage_account_id
#   private_connection_subresource_names = local.adls_dfs_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.adls_dfs_private_dns_zone_id
#   depends_on                           = [module.adls]
# }

module "ai_search" {
  source                                   = "../../../Modules/aiSearch" # Path to the module directory
  search_service_name                      = local.ai_search_name
  resource_group_name                      = local.resource_group_name
  location                                 = local.location
  sku                                      = var.ai_search_sku
  local_authentication_enabled             = local.local_authentication_enabled
  authentication_failure_mode              = var.authentication_failure_mode
  public_network_access_enabled            = local.public_network_access_enabled_ai_search
  identity_type                            = var.search_identity_type
  tags                                     = merge(var.tags, var.ai_search_tags)
  customer_managed_key_enforcement_enabled = var.customer_managed_key_enforcement_enabled
  semantic_search_sku                      = var.semantic_search_sku
  depends_on                               = [module.rg]
}

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

module "hub_private_endpoint_ai_search" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_connection_resource_id       = module.ai_search.ai_search_id
  private_endpoint_name                = local.hub_ai_search_private_endpoint_config.private_endpoint_name
  private_service_connection_name      = local.hub_ai_search_private_endpoint_config.private_service_connection_name
  private_dns_zone_group_name          = local.hub_ai_search_private_endpoint_config.private_dns_zone_group_name
  private_dns_zone_ids                 = local.hub_ai_search_private_endpoint_config.private_dns_zone_ids
  private_connection_subresource_names = local.hub_ai_search_private_endpoint_config.private_connection_subresource_names
  is_manual_connection                 = local.hub_ai_search_private_endpoint_config.is_manual_connection
  depends_on                           = [module.rg, module.ai_search]
}


# ......................................................
# Creating Azure Container Registry
# ......................................................
module "container_registry" {
  source                        = "../../../Modules/acr"
  container_registry_name       = local.container_registry_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  sku                           = var.container_registry.sku
  public_network_access_enabled = var.container_registry.public_network_access_enabled
  identity                      = var.container_registry.identity
  tags                          = merge(var.tags, var.container_registry.tags)
  depends_on                    = [module.rg]
}

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

module "hub_private_endpoint_acr" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_endpoint_name                = local.hub_acr_pep_name
  private_service_connection_name      = "${local.container_registry_name}-psc"
  private_connection_resource_id       = module.container_registry.id
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.hub_acr_private_dns_zone_id
  private_connection_subresource_names = local.acr_subresource_names
  is_manual_connection                 = local.is_manual_connection
  depends_on                           = [module.rg, module.container_registry]
}

# ......................................................
# Creating APIM
# ......................................................
module "external_apim" {
  source                        = "../../../Modules/apim"
  name                          = local.apim_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  publisher_name                = var.apim_config.publisher_name
  publisher_email               = var.apim_config.publisher_email
  sku_name                      = var.apim_config.sku_name
  public_ip_address_id          = data.azurerm_public_ip.apim_public_ip.id
  public_network_access_enabled = var.apim_config.public_network_access_enabled
  virtual_network_type          = var.apim_config.virtual_network_type
  tags                          = merge(var.tags, var.apim_config.tags)
  identity                      = var.apim_config.identity
  virtual_network_configuration = {
    subnet_id = data.azurerm_subnet.apim_subnet.id
  }
}

# ...................................................................
# Creating Role ("Cognitive Services OpenAI User") Assignment MID.
# ...................................................................
module "role_assignment_apim_managed_identity" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.apim_managed_identity_role_definition_name
  scope                = module.open_ai.openai_id
  principal_id         = local.apim_managed_identity_principal_id
  depends_on           = [module.rg, module.external_apim]
}

# ...................................................................
# Creating Role ("Cognitive Services OpenAI User") Assignment MID.
# ...................................................................
module "role_assignment_uat_apim_managed_identity" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.apim_managed_identity_role_definition_name
  scope                = module.open_ai.openai_id
  principal_id         = local.uat_apim_managed_identity_principal_id
  depends_on           = [module.rg, module.external_apim]
}

# --------------------------------
module "hub_private_endpoint_tfstatesa" {
  source = "../../../Modules/networking/privateEndpoint"
  providers = {
    azurerm = azurerm.hub
  }
  location                             = local.location
  resource_group_name                  = var.hub_pep_resource_group_name #hub
  subnet_endpoint_id                   = var.hub_pep_subnet_id
  private_connection_resource_id       = data.azurerm_storage_account.tfstate.id
  private_endpoint_name                = local.hub_sa_private_endpoint_config.private_endpoint_name
  private_service_connection_name      = local.hub_sa_private_endpoint_config.private_service_connection_name
  private_dns_zone_group_name          = local.hub_sa_private_endpoint_config.private_dns_zone_group_name
  private_dns_zone_ids                 = local.hub_sa_private_endpoint_config.private_dns_zone_ids
  private_connection_subresource_names = local.hub_sa_private_endpoint_config.private_connection_subresource_names
  is_manual_connection                 = local.hub_sa_private_endpoint_config.is_manual_connection
  depends_on                           = [data.azurerm_storage_account.tfstate]
}
