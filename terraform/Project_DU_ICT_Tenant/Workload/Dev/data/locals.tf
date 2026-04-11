locals {
  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  data_rg_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-data-rg"

  storage_account_name        = lower("dusa${var.bu_name}${var.environment}hrdata")
  storage_container_name      = lower("dusa${var.bu_name}${var.environment}hrdatacont")
  cosmos_mongodb_account_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-database-cosmos"
  cosmos_nosql_account_name   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-database-cosno"
  kv_name                     = "${var.tenant_name}-platfor-${var.bu_name}-${var.environment}-kv"

  key_vault_private_endpoint_name      = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-kv-pep"
  adls_blob_private_endpoint_name      = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-sahrdata-blob-pep"
  adls_dfs_private_endpoint_name       = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-sahrdata-dfs-pep"
  cosmos_mongodb_private_endpoint_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-database-cosmos-pep"
  cosmos_nosql_private_endpoint_name   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-database-cosno-pep"
  mongo_database_name                  = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-database-cosmon"
  nosql_database_name                  = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-database-nosql"
  umid_name                            = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-uaid"

  private_service_connection_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pep-connection"

  key_vault_subresource_names      = ["vault"]
  adls_blob_subresource_names      = ["blob"]
  adls_dfs_subresource_names       = ["dfs"]
  cosmos_mongodb_subresource_names = ["MongoDB"]
  cosmos_nosql_subresource_names   = ["Sql"]

  private_dns_zone_group_name = "default"

  is_hns_enabled                         = true
  public_network_access_enabled_adls     = true
  public_network_access_enabled_kv       = false
  public_network_access_enabled_cosmosdb = false
  is_virtual_network_filter_enabled      = true
  is_manual_connection                   = false

  enabled_for_disk_encryption = false
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  secrets = [
    {
      secret_name  = "ict-platform-hrbot-dev-database-cosno-keys"
      secret_value = "${module.cosmos_nosql.cosmos_db_key}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-database-cosno-connection-string"
      secret_value = "${module.cosmos_nosql.cosmos_db_connection_string}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-database-cosno-uri"
      secret_value = "${module.cosmos_nosql.cosmos_db_uri}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-di-keys"
      secret_value = "${data.azurerm_cognitive_account.di.primary_access_key}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-di-endpoint"
      secret_value = "${data.azurerm_cognitive_account.di.endpoint}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-srch-keys"
      secret_value = "${data.azurerm_search_service.srch.primary_key}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-srch-uri"
      secret_value = "https://ict-platform-hrbot-dev-srch.search.windows.net"
    },
    {
      secret_name  = "ict-platform-hrbot-prod-oai-keys"
      secret_value = "283906ace00542c6a4021be92d9d4edc"
    },
    {
      secret_name  = "ict-platform-hrbot-prod-oai-endpoint"
      secret_value = "https://ict-platform-hrbot-prod-oai.openai.azure.com/"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-database-cosmos-connection-string"
      secret_value = "${module.cosmos_mongodb.cosmos_db_connection_string}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-database-cosmos-keys"
      secret_value = "${module.cosmos_mongodb.cosmos_db_key}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-database-cosmos-uri"
      secret_value = "${module.cosmos_mongodb.cosmos_db_uri}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-appi-instrumentation-key"
      secret_value = "${data.azurerm_application_insights.appi.instrumentation_key}"
    },
    {
      secret_name  = "ict-platform-hrbot-dev-appi-connection-string"
      secret_value = "${data.azurerm_application_insights.appi.connection_string}"
    }
  ]

}
