locals {
  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  data_rg_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-data-rg"

  storage_account_name    = lower("dusa${var.bu_name}${var.environment}gitexdata")
  storage_containers_name = ["healthcarebot", "generalbot", "hrbot", "basicbot"]
  container_access_type   = "private"
  kv_name                 = "${var.tenant_name}-plat-${var.bu_name}-${var.environment}-kv"
  umid_name               = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-uaid"

  key_vault_private_endpoint_name    = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-kv-pep"
  adls_blob_private_endpoint_name    = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-sagitexdata-blob-pep"
  adls_dfs_private_endpoint_name     = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-sagitexdata-dfs-pep"
  tfstate_blob_private_endpoint_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-tfstate-blob-pep"

  private_service_connection_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pep-connection"

  key_names               = ["ict-platform-gitex-adls-cmk", "ict-platform-gitex-trans-cmk", "ict-platform-gitex-di-cmk", "ict-platform-gitex-spch-cmk"]
  kv_role_definition_name = "Key Vault Crypto Officer"

  key_vault_subresource_names = ["vault"]
  adls_blob_subresource_names = ["blob"]
  adls_dfs_subresource_names  = ["dfs"]

  private_dns_zone_group_name        = "default"
  is_hns_enabled                     = true
  public_network_access_enabled_adls = false
  public_network_access_enabled_kv   = false
  is_virtual_network_filter_enabled  = true
  is_manual_connection               = false

  enabled_for_disk_encryption = false
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  secrets = [

    {
      secret_name  = "ict-platform-gitex-prod-di-keys"
      secret_value = "${data.azurerm_cognitive_account.di.primary_access_key}"
    },
    {
      secret_name  = "ict-platform-gitex-prod-di-endpoint"
      secret_value = "${data.azurerm_cognitive_account.di.endpoint}"
    },
    {
      secret_name  = "ict-platform-gitex-prod-srch-keys"
      secret_value = "${data.azurerm_search_service.srch.primary_key}"
    },
    {
      secret_name  = "ict-platform-gitex-prod-trsl-keys"
      secret_value = "${data.azurerm_cognitive_account.trsl.primary_access_key}"
    },
    {
      secret_name  = "ict-platform-gitex-prod-trsl-endpoint"
      secret_value = "${data.azurerm_cognitive_account.trsl.endpoint}"
    },
    {
      secret_name  = "ict-platform-gitex-prod-srch-uri"
      secret_value = "https://ict-platform-gitex-prod-srch.search.windows.net"
    },
    {
      secret_name  = "ict-platform-gitex-prod-oai-keys"
      secret_value = "1224bdb908784d0ca5dc5920810ccb7a" 
    },
    {
      secret_name  = "ict-platform-gitex-prod-oai-endpoint"
      secret_value = "https://ict-platform-ccai-oai.openai.azure.com/" 
    },
    {
      secret_name  = "ict-platform-gitex-prod-appi-instrumentation-key"
      secret_value = "${data.azurerm_application_insights.appi.instrumentation_key}"
    },
    {
      secret_name  = "ict-platform-gitex-prod-appi-connection-string"
      secret_value = "${data.azurerm_application_insights.appi.connection_string}"
    },
    {
      secret_name  = "encryption-key"
      secret_value = "b'MKaVEa7Cun5m3OBDUjwwRY8SB0-BRLmuRQKKrAv6xWA='"
    },
    {
      secret_name  = "dusagitexprodgitexdata-key"
      secret_value = "${module.adls.storage_account_key}"
    },
    {
      secret_name  = "dusagitexprodgitexdata-connection-string"
      secret_value = "${module.adls.storage_account_connection_string}"
    }
  ]

}
