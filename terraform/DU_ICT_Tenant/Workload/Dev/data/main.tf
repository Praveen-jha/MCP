# ......................................................
# Creating New Resource Group
# ......................................................
module "rg" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.data_rg_name
  resource_group_location = var.rg_location
}

# ......................................................
# Creating New ADLS Gen2 Account
# ......................................................

module "adls" {
  source                        = "../../../Modules/adls/storageAccount"
  storage_account_name          = local.storage_account_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  storage_account_tier          = var.storage_account_tier
  account_replication_type      = var.account_replication_type
  is_hns_enabled                = local.is_hns_enabled
  storage_identity_type         = var.storage_identity_type
  storage_identity_id           = [module.user_managed_identity.umid]
  public_network_access_enabled = local.public_network_access_enabled_adls
  tags                          = var.adls_tags
  depends_on                    = [module.rg, module.user_managed_identity]
}

# ......................................................
# Creating Container in ADLS Gen2
# ......................................................

module "container" {
  source                 = "../../../Modules/adls/container"
  storage_account_name   = module.adls.storage_account_name
  storage_container_name = local.storage_container_name
  depends_on             = [module.adls]
}

# ......................................................
# Creating New Cosmos MongoDB
# ......................................................

module "cosmos_mongodb" {
  source                                     = "../../../Modules/cosmosdb_mongo"
  cosmosdb_account_name                      = local.cosmos_mongodb_account_name
  location                                   = local.location
  resource_group_name                        = local.resource_group_name
  cosmosdb_account_offer_type                = var.cosmosdb_account_offer_type
  cosmosdb_account_kind                      = var.cosmos_mongodb_account_kind
  public_network_access_enabled              = local.public_network_access_enabled_cosmosdb
  cosmosdb_account_capabilities              = var.cosmosdb_account_capabilities
  cosmosdb_account_consistency_level         = var.cosmosdb_account_consistency_level
  cosmosdb_account_geo_location_primary      = var.cosmosdb_account_geo_location_primary
  cosmosdb_account_failover_priority_primary = var.cosmosdb_account_failover_priority_primary
  is_virtual_network_filter_enabled          = local.is_virtual_network_filter_enabled
  cosmosdb_identity_type                     = var.cosmosdb_identity_type
  cosmosdb_identity_id                       = [module.user_managed_identity.umid]
  mongo_database_name                        = local.mongo_database_name
  throughput                                 = var.throughput
  cosmos_mongodb_tags                        = var.cosmos_mongodb_tags
  depends_on                                 = [module.rg, module.user_managed_identity]
}

# ......................................................
# Creating New Cosmos NoSQL
# ......................................................

module "cosmos_nosql" {
  source                                     = "../../../Modules/cosmosdb_noSQL"
  cosmosdb_account_name                      = local.cosmos_nosql_account_name
  location                                   = local.location
  resource_group_name                        = local.resource_group_name
  cosmosdb_account_offer_type                = var.cosmosdb_account_offer_type
  cosmosdb_account_kind                      = var.cosmos_nosql_account_kind
  public_network_access_enabled              = local.public_network_access_enabled_cosmosdb
  cosmosdb_account_consistency_level         = var.cosmosdb_account_consistency_level
  cosmosdb_account_geo_location_primary      = var.cosmosdb_account_geo_location_primary
  cosmosdb_account_failover_priority_primary = var.cosmosdb_account_failover_priority_primary
  is_virtual_network_filter_enabled          = local.is_virtual_network_filter_enabled
  cosmosdb_identity_type                     = var.cosmosdb_identity_type
  cosmosdb_identity_id                       = [module.user_managed_identity.umid]
  nosql_database_name                        = local.nosql_database_name
  cosmos_nosql_tags                          = var.cosmos_nosql_tags
  depends_on                                 = [module.rg, module.user_managed_identity]
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
  tags                          = var.keyvault_tags
  depends_on                    = [module.rg]
}

# ......................................................
# Creating Key Vault Secret
# ......................................................

module "kv_secret" {
  count        = length(local.secrets)
  source       = "../../../Modules/kv/secrets"
  key_vault_id = module.keyvault.key_vault_id
  secret_name  = local.secrets[count.index].secret_name
  secret_value = local.secrets[count.index].secret_value
  depends_on   = [module.keyvault, module.cosmos_mongodb, module.cosmos_nosql]
}

# ......................................................
# Creating Private Endpoint for Key Vault
# ......................................................

module "private_endpoint_kv" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.key_vault_private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.keyvault.key_vault_id
  private_connection_subresource_names = local.key_vault_subresource_names
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.key_vault_private_dns_zone_id
  depends_on                           = [module.keyvault]
}

# ......................................................
# Creating Private Endpoint for ADLS Blob
# ......................................................

module "private_endpoint_blob" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.adls_blob_private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.adls.storage_account_id
  private_connection_subresource_names = local.adls_blob_subresource_names
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.adls_blob_private_dns_zone_id
  depends_on                           = [module.adls]
}

# ......................................................
# Creating Private Endpoint for ADLS Dfs
# ......................................................

module "private_endpoint_dfs" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.adls_dfs_private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.adls.storage_account_id
  private_connection_subresource_names = local.adls_dfs_subresource_names
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.adls_dfs_private_dns_zone_id
  depends_on                           = [module.adls]
}

# ......................................................
# Creating Private Endpoint for CosmosDB MongoDB
# ......................................................

module "private_endpoint_cosmos_mongodb" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.cosmos_mongodb_private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.cosmos_mongodb.cosmos_db_id
  private_connection_subresource_names = local.cosmos_mongodb_subresource_names
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.cosmos_mongodb_private_dns_zone_id
  depends_on                           = [module.cosmos_mongodb]
}

# ......................................................
# Creating Private Endpoint for CosmosDB NoSQL
# ......................................................

module "private_endpoint_cosmos_nosql" {
  source                               = "../../../Modules/networking/privateEndpoint"
  resource_group_name                  = local.resource_group_name
  location                             = local.location
  private_endpoint_name                = local.cosmos_nosql_private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
  private_service_connection_name      = local.private_service_connection_name
  private_connection_resource_id       = module.cosmos_nosql.cosmos_db_id
  private_connection_subresource_names = local.cosmos_nosql_subresource_names
  is_manual_connection                 = local.is_manual_connection
  private_dns_zone_group_name          = local.private_dns_zone_group_name
  private_dns_zone_ids                 = var.cosmos_nosql_private_dns_zone_id
  depends_on                           = [module.cosmos_nosql]
}

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
