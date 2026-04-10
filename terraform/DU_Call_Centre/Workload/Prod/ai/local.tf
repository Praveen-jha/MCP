locals {

  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  ai_rg_name = "${var.tenant_name}-platform-${var.bu_name}-ai-rg"

  speech_service_name                        = "${var.tenant_name}-platform-${var.bu_name}-spch"
  language_service_name                      = "${var.tenant_name}-platform-${var.bu_name}-lang"
  translator_service_name                    = "${var.tenant_name}-platform-${var.bu_name}-trsl"
  openAI_account_name                        = "${var.tenant_name}-platform-${var.bu_name}-oai"
  document_intelligence_name                 = "${var.tenant_name}-platform-${var.bu_name}-docintel"
  ai_search_name                             = "${var.tenant_name}-platform-${var.bu_name}-srch"
  container_registry_name                    = "${var.tenant_name}platform${var.bu_name}acruaen01"
  apim_name                                  = "${var.tenant_name}-platform-cog-prd-apim-uaen-01"
  apim_managed_identity_role_definition_name = "Cognitive Services OpenAI User"
  apim_managed_identity_principal_id         = "1438eff3-e4c0-4a62-b587-1f13395266fb"
  uat_apim_managed_identity_principal_id     = "1c6ba8aa-3392-407b-8cb9-927d08a62239"
  public_network_access_enabled              = true

  is_manual_connection        = false
  private_dns_zone_group_name = "default"
  kind                        = "OpenAI"
  speech_service_kind         = "SpeechServices"
  language_service_kind       = "TextAnalytics"
  translator_service_kind     = "TextTranslation"

  kv_name   = "${var.tenant_name}-platform-${var.bu_name}-kv"
  umid_name = "${var.tenant_name}-platform-${var.bu_name}-uaid"

  public_network_access_enabled_kv = true

  kv_role_definition_name         = "Key Vault Crypto Officer"
  kv_role_secrets_definition_name = "key vault secrets officer"

  contributor_role_definition_name = "Contributor"
  storage_role_definition_name     = "contributor"

  contributor_principal_id = "636cb04d-fcbd-4b24-87b2-3f27302dc43a"

  key_vault_config = {
    key_vault = {
      key_vault_subresource_names      = ["vault"]
      public_network_access_enabled_kv = false
      enabled_for_disk_encryption      = false
      purge_protection_enabled         = true
      soft_delete_retention_days       = 7
      tags                             = merge(var.tags, { "Workload Name" : "Key Vault" })
    }
  }

  # kv_pep_name  = "${var.tenant_name}-platform-cog-prd-kv-pep-uaen-01"  //ict-platform-cog-prd-kv-pep-uaen-01
  # di_pep_name  = "${var.tenant_name}-platform-cog-prd-di-pep-uaen-01"  //ict-platform-cog-prd-di-pep-uaen-01
  hub_di_pep_name = "${var.tenant_name}-platform-shrd-hub-di-pep-uaen-01" //ict-platform-cog-prd-di-pep-uaen-01
  # acr_pep_name = "${var.tenant_name}-platform-cog-prd-acr-pep-uaen-01" //ict-platform-cog-prd-acr-pep-uaen-01
  hub_acr_pep_name = "${var.tenant_name}-platform-shrd-hub-acr-pep-uaen-01" //ict-platform-cog-prd-acr-pep-uaen-01
  # Key values Stored in Key Vault
  key_names = [                   #Note:Do not change the sequence or delete the key as it is used in different modules with key_name Index number for CMK.
    "ict-platform-ccai-spch-cmk", #used this key for speech_service[Index No.0]
    "ict-platform-ccai-lang-cmk", #used this key for language_service[Index No.1]
    "ict-platform-ccai-trsl-cmk", #used this key for translator_service[Index No.2]
    "ict-platform-ccai-oai-cmk",  #used this key for openAI_account[Index No.3]
    "ict-platform-ccai-di-cmk",   #used this key for document_intelligence[Index No.4]
    "dusa-ccai-blob-mlw-cmk",     #used this key for storage_ml[Index No.5]
    "ict-platform-ccai-mlw-cmk",  #used this key for ml_workspace[Index No.6]
  ]

  # secrets value stored in Key Vault
  secrets = [
    {
      secret_name  = "ict-platform-ccai-docintel"
      secret_value = "${module.document_intelligence.primary_access_key}"
    }
  ]

  enabled_for_disk_encryption = false
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  # #Required Variables for ML compute instance configuraiton
  # ml_workspace_config = {
  #   ml_workspace = {
  #     ml_workspace_name                    = "${var.tenant_name}-platform-${var.bu_name}-mlw"
  #     isolation_mode_ml                    = "Disabled"
  #     public_network_access_enabled_ml     = false
  #     private_connection_subresource_names = ["amlworkspace"]
  #     ml_workspace_identity_type           = "UserAssigned"
  #     ml_workspace_identity_id             = [""]
  #     tags                                 = merge(var.tags, { "Workload Name" : "ML Workspace" })
  #   }
  # }

  #Required Variables for Application insights(aapi) for ML workspace
  application_insights_config = {
    ml_workspace = {
      name             = "${var.tenant_name}-platform-${var.bu_name}-mlw-aapi"
      application_type = "web"
    }
  }

  # #Azure Machine learning compute instant naming create and used in main.tf for ml vm name.
  # ml_vm_configs = {
  #   for vm_key, vm_value in var.ml_vm_configs :
  #   vm_key => "${var.tenant_name}-${var.bu_name}-${vm_key}"
  # }

  # Required Variables for Storage Account / ADLS
  storage_accounts = {
    ml_storage = { #ml_storage value used in main.tf location at "storage_account_id = module.adls.ml_storage.storage_account_id" and "scope = module.adls.ml_storage.storage_account_id"
      storage_account_name               = "dusa${var.bu_name}blobmlw"
      storage_identity_type              = "UserAssigned"
      public_network_access_enabled_adls = false
      account_replication_type           = "LRS"
      storage_account_tier               = "Standard"
      is_hns_enabled                     = false
      key_name_cmk                       = local.key_names[5] # Key created in key vault and called here from local.key_names[5] key Value is passed "dusa-ccai-blob-mlw-cmk"
      endpoint                           = ["blob", "file"]
      tags                               = merge(var.tags, { "Workload Name" : "blob-mlwstorage" })
    }
  }

  adls_blob_subresource_names = ["blob"]
  adls_dfs_subresource_names  = ["dfs"]
  adls_file_subresource_names = ["file"]
  acr_subresource_names       = ["registry"]

  # Diagnostic settings for Speech service
  spch_diagnostic_setting_name = "spchServiceDiagnosticLogsToWorkspace"
  spch_log_category = {
    category        = [],
    category_groups = ["Audit", "allLogs"]
  }
  spch_metrics = ["AllMetrics"]

  # Diagnostic settings for Language service
  lang_diagnostic_setting_name = "langServiceDiagnosticLogsToWorkspace"
  lang_log_category = {
    category        = [],
    category_groups = ["Audit", "allLogs"]
  }
  lang_metrics = ["AllMetrics"]

  # Diagnostic settings for Translator service
  trsl_diagnostic_setting_name = "trslServiceDiagnosticLogsToWorkspace"
  trsl_log_category = {
    category        = [],
    category_groups = ["Audit", "allLogs"]
  }
  trsl_metrics = ["AllMetrics"]

  # Diagnostic settings for Azure OpenAI
  oai_diagnostic_setting_name = "oaiServiceDiagnosticLogsToWorkspace"
  oai_log_category = {
    category        = [],
    category_groups = ["Audit", "allLogs"]
  }
  oai_metrics = ["AllMetrics"]

  log_category = {
    category        = [],
    category_groups = []
  }
  metrics = ["Transaction", "Capacity"]

  local_authentication_enabled            = true
  public_network_access_enabled_ai_search = true

  # open_ai_private_endpoint_config = {
  #   private_endpoint_name                = "${var.tenant_name}-platform-cog-prd-oai-pep-uaen-01" # ict-platform-cog-prd-oai-pep-uaen-01
  #   private_service_connection_name      = "${local.openAI_account_name}-account-psc"
  #   private_dns_zone_group_name          = "default"
  #   private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com"]
  #   private_connection_subresource_names = ["account"]
  #   is_manual_connection                 = false
  # }

  hub_open_ai_private_endpoint_config = {
    private_endpoint_name                = "${var.tenant_name}-platform-shrd-hub-oai-pep-uaen-01" # ict-platform-cog-prd-oai-pep-uaen-01
    private_service_connection_name      = "${local.openAI_account_name}-account-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com"]
    private_connection_subresource_names = ["account"]
    is_manual_connection                 = false
  }

  # speech_service_private_endpoint_config = {
  #   private_endpoint_name                = "${var.tenant_name}-platform-cog-prd-spch-pep-uaen-01" # ict-platform-cog-prd-spch-pep-uaen-01
  #   private_service_connection_name      = "${local.speech_service_name}-account-psc"
  #   private_dns_zone_group_name          = "default"
  #   private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
  #   private_connection_subresource_names = ["account"]
  #   is_manual_connection                 = false
  # }

  # language_service_private_endpoint_config = {
  #   private_endpoint_name                = "${var.tenant_name}-platform-cog-prd-lang-pep-uaen-01" # ict-platform-cog-prd-lang-pep-uaen-01
  #   private_service_connection_name      = "${local.language_service_name}-account-psc"
  #   private_dns_zone_group_name          = "default"
  #   private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
  #   private_connection_subresource_names = ["account"]
  #   is_manual_connection                 = false
  # }

  # translator_service_private_endpoint_config = {
  #   private_endpoint_name                = "${var.tenant_name}-platform-cog-prd-trsl-pep-uaen-01" # ict-platform-cog-prd-trsl-pep-uaen-01
  #   private_service_connection_name      = "${local.translator_service_name}-account-psc"
  #   private_dns_zone_group_name          = "default"
  #   private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
  #   private_connection_subresource_names = ["account"]
  #   is_manual_connection                 = false
  # }

  # ai_search_private_endpoint_config = {
  #   private_endpoint_name                = "${var.tenant_name}-platform-cog-prd-srch-pep-uaen-01" # ict-platform-cog-prd-srch-pep-uaen-01
  #   private_service_connection_name      = "${local.ai_search_name}-searchService-psc"
  #   private_dns_zone_group_name          = "default"
  #   private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"]
  #   private_connection_subresource_names = ["searchService"]
  #   is_manual_connection                 = false
  # }
  hub_key_vault_private_endpoint_config = {
    private_endpoint_name                = "${var.tenant_name}-platform-shrd-hub-kv-pep-uaen-01"
    private_service_connection_name      = "${local.kv_name}-vault-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
    private_connection_subresource_names = ["vault"]
    is_manual_connection                 = false
  }

  hub_speech_service_private_endpoint_config = {
    private_endpoint_name                = "${var.tenant_name}-platform-shrd-hub-spch-pep-uaen-01"
    private_service_connection_name      = "${local.speech_service_name}-account-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
    private_connection_subresource_names = ["account"]
    is_manual_connection                 = false
  }

  hub_language_service_private_endpoint_config = {
    private_endpoint_name                = "${var.tenant_name}-platform-shrd-hub-lang-pep-uaen-01"
    private_service_connection_name      = "${local.language_service_name}-account-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
    private_connection_subresource_names = ["account"]
    is_manual_connection                 = false
  }

  hub_translator_service_private_endpoint_config = {
    private_endpoint_name                = "${var.tenant_name}-platform-shrd-hub-trsl-pep-uaen-01"
    private_service_connection_name      = "${local.translator_service_name}-account-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
    private_connection_subresource_names = ["account"]
    is_manual_connection                 = false
  }

  hub_ai_search_private_endpoint_config = {
    private_endpoint_name                = "${var.tenant_name}-platform-shrd-hub-srch-pep-uaen-01"
    private_service_connection_name      = "${local.ai_search_name}-searchService-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"]
    private_connection_subresource_names = ["searchService"]
    is_manual_connection                 = false
  }

  # tfstate_sa_name        = "dusaccaisharedtfstate"
  hub_tfstatesa_pep_name = "ict-platform-ccai-cog-tfstate-pe-uaen-01"
  tfstate_sa_rg_name     = "ict-platform-ccai-shared-tfstate-rg"

  hub_sa_private_endpoint_config = {
    tfstate_sa_name                      = "dusaccaisharedtfstate"
    tfstate_sa_rg_name                   = "ict-platform-ccai-shared-tfstate-rg"
    private_endpoint_name                = "${var.tenant_name}-platform-shrd-hub-tfstate-cog-prd-pep-uaen-01"
    private_service_connection_name      = "dusaccaisharedtfstate-blob-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
    private_connection_subresource_names = ["blob"]
    is_manual_connection                 = false
  }
}
