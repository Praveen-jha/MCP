locals {
  resource_group_name      = var.rg_creation == "new" ? module.RG[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location                 = var.rg_creation == "new" ? module.RG[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location
  hub_data_rg_name         = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
  pip_subnet_name          = "ict-platform-shrd-hub-comp-snet-uaen-01"
  hub_network_rg_name      = "ict-platform-shrd-hub-network-rg-uaen-01"
  hub_virtual_network_name = "${var.tenant_name}-platform-${var.environment}-vnet-${var.location_shortname}-01"
  #   umid_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-data-uaid"
  private_dns_zone_group_name = "default"
  is_manual_connection        = false
  #   kv_role_definition_name         = "Key Vault Crypto Officer"
  #   kv_role_secrets_definition_name = "key vault secrets officer"
  key_vault_config = {
    key_vault = {
      kv_name                          = "${var.tenant_name}-platform-${var.environment}-kv"
      key_vault_subresource_names      = ["vault"]
      public_network_access_enabled_kv = false
      enabled_for_disk_encryption      = false
      purge_protection_enabled         = true
      soft_delete_retention_days       = 7
      tags                             = merge(var.tags, { "Workload Name" : "Key Vault" })
    }
  }

  #   secrets = [
  #     {
  #       secret_name  = "dusaccaidevblobpostcall"
  #       secret_value = "${module.adls["postCall_storage"].primary_access_key}"
  #     },
  #     
  #   key_names = {
  #     postCall_storage     = "dusa-ccai-dev-blob-postcall-cmk"  # used this key for postCall_storage
  #     # dataIngestion_storage = "dusa-ccai-dev-adls-ingesting-cmk" # used this key for dataIngestion_storage
  #   }

  # kv_pep_name  = "${var.tenant_name}-platform-cog-prd-kv-pep-uaen-01"  //ict-platform-cog-prd-kv-pep-uaen-01
  # di_pep_name  = "${var.tenant_name}-platform-cog-prd-di-pep-uaen-01"  //ict-platform-cog-prd-di-pep-uaen-01
  # acr_pep_name = "${var.tenant_name}-platform-cog-prd-acr-pep-uaen-01" //ict-platform-cog-prd-acr-pep-uaen-01

  # open_ai_private_endpoint_config = {
  #   private_endpoint_name                = "${var.tenant_name}-platform-cog-prd-oai-pep-uaen-01" # ict-platform-cog-prd-oai-pep-uaen-01
  #   private_service_connection_name      = "${local.openAI_account_name}-account-psc"
  #   private_dns_zone_group_name          = "default"
  #   private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com"]
  #   private_connection_subresource_names = ["account"]
  #   is_manual_connection                 = false
  # }
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

}

 
