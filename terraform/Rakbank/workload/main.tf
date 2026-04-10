# .............................................................................
#                        key vault
# .............................................................................

# # Creating an Azure key vault to store secrets securely
module "keyvault" {
  source                        = "../module/key_vault"
  key_vault_name                = var.resource_config.key_vault_name
  location                      = var.resource_config.location
  resource_group_name           = var.resource_config.resource_group_name
  sku_name                      = var.resource_config.kv_sku_name
  enabled_for_disk_encryption   = local.enabled_for_disk_encryption
  purge_protection_enabled      = local.purge_protection_enabled
  public_network_access_enabled = var.resource_config.public_network_access_enabled
  soft_delete_retention_days    = local.soft_delete_retention_days
  tags                          = module.rakbank_tags.tags
  key_definitions               = local.key_definitions
  secret_definitions            = local.secret_definitions
  enable_rbac_authorization     = local.enable_rbac_authorization
}

# .............................................................................
#                       shared storage account
# .............................................................................


# Module for provisioning an Azure Data Lake Storage Account
module "adls" {
  source = "../module/storage_account"

  storage_account_name                     = local.storage_account_name
  location                                 = var.resource_config.location
  resource_group_name                      = var.resource_config.resource_group_name
  storage_account_tier                     = local.storage_account_tier
  account_replication_type                 = var.resource_config.storage_account_replication
  is_hns_enabled                           = local.is_hns_enabled
  infrastructure_encryption_enabled        = local.infrastructure_encryption_enabled
  shared_access_key_enabled                = local.shared_access_key_enabled
  public_network_access_enabled            = var.resource_config.public_network_access_enabled
  network_rules_ip_rules                   = local.network_rules_ip_rules
  network_rules_virtual_network_subnet_ids = local.network_rules_virtual_network_subnet_ids
  delete_retention_policy_days             = local.delete_retention_policy_days
  min_tls_version                          = local.min_tls_version
  local_user_enabled                       = local.local_user_enabled
  tags                                     = module.rakbank_tags.tags
  key_vault_id                             = local.key_vault_id
  key_name                                 = local.key_name
  storage_account_containers               = local.storage_account_containers
  identity                                 = local.storage_account_identity
  key_scope_id                             = local.key_role_id
}


# .............................................................................
#                       function app storage account
# .............................................................................


# Module for provisioning an Azure Data Lake Storage Account for function app
module "function_adls" {
  source = "../module/storage_account"

  storage_account_name                     = local.fa_storage_account_name
  location                                 = var.resource_config.location
  resource_group_name                      = var.resource_config.resource_group_name
  storage_account_tier                     = local.storage_account_tier
  account_replication_type                 = var.resource_config.storage_account_replication
  is_hns_enabled                           = local.is_hns_enabled
  infrastructure_encryption_enabled        = local.infrastructure_encryption_enabled
  shared_access_key_enabled                = local.shared_access_key_enabled
  public_network_access_enabled            = var.resource_config.public_network_access_enabled
  network_rules_ip_rules                   = local.network_rules_ip_rules
  network_rules_virtual_network_subnet_ids = local.network_rules_virtual_network_subnet_ids
  delete_retention_policy_days             = local.delete_retention_policy_days
  min_tls_version                          = local.min_tls_version
  local_user_enabled                       = local.local_user_enabled
  tags                                     = module.rakbank_tags.tags
  key_vault_id                             = local.key_vault_id
  key_name                                 = local.key_name
  storage_account_containers               = local.fa_storage_account_containers
  identity                                 = local.storage_account_identity
  key_scope_id                             = local.key_role_id
}


# # .............................................................................
# #                        sql server
# # .............................................................................


# module for creating an azure sql server instance
module "sql_server" {
  source = "../module/sql_server"

  sql_server_name                   = var.resource_config.sql_server_name
  location                          = var.resource_config.location
  rg_name                           = data.azurerm_resource_group.data_rg.name
  tags                              = module.rakbank_tags.tags
  sql_server_version                = local.sql_server_version
  sql_server_admin_password         = local.sql_server_admin_password
  sql_server_admin_login            = local.sql_server_admin_login
  sql_server_azure_ad_administrator = local.sql_server_azure_ad_administrator
  sql_server_min_tls_version        = local.sql_server_min_tls_version
  sql_server_identity               = local.sql_server_identity
  sql_public_network_access_enabled = var.resource_config.public_network_access_enabled
  key_vault_key_id                  = local.key_vault_key_id
  key_scope_id                      = local.key_role_id
  sql_databases                     = local.sql_databases
  auditing_policy_enabled           = local.auditing_policy_enabled
}



# .............................................................................
#                     cosmos uid
# .............................................................................

# module for creating a user assigned managed identity
module "cosmos_user_assigned_identity" {
  source              = "../module/user_managed_identity"
  identity_name       = local.cosmos_identity_name
  location            = var.resource_config.location
  resource_group_name = data.azurerm_resource_group.data_rg.name
  tags                = module.rakbank_tags.tags
}


# .............................................................................
#                        function app uid
# .............................................................................


#  add managed identity for fa and role assignement
# module for creating a user assigned managed identity
module "function_user_assigned_identity" {
  source              = "../module/user_managed_identity"
  identity_name       = local.function_identity_name
  location            = var.resource_config.location
  resource_group_name = data.azurerm_resource_group.data_rg.name
  tags                = module.rakbank_tags.tags
}


# .............................................................................
#                        Role assignment
# .............................................................................

# Module for assigning roles to resources
module "role_assignement" {
  source               = "../module/role_assignment"
  for_each             = local.role_assignments
  scope                = each.value.key_scope_id
  principal_id         = each.value.principle_id
  role_definition_name = each.value.role_definition_name

  depends_on = [module.function_user_assigned_identity, module.cosmos_user_assigned_identity, module.function_adls, module.disk_encryption_set]
}



# .............................................................................
#                        Cosmos Database
# .............................................................................

# Module for provisioning a Cosmos DB instance
module "cosmos_database" {
  source     = "../module/cosmos_db"
  depends_on = [module.cosmos_user_assigned_identity, module.role_assignement]

  cosmos_db_name                     = var.resource_config.cosmos_db_name
  tags                               = module.rakbank_tags.tags
  location                           = var.resource_config.location
  rg_name                            = data.azurerm_resource_group.data_rg.name
  cosmos_kind                        = var.resource_config.cosmos_kind
  cosmos_geo_location                = local.cosmos_geo_location
  cosmos_automatic_failover_enabled  = local.cosmos_automatic_failover_enabled
  key_vault_key_id                   = local.key_vault_key_versionless_id
  cosmos_identity                    = local.cosmos_identity
  cosmos_consistency_policy          = local.cosmos_consistency_policy
  cosmos_min_tls_version             = local.cosmos_min_tls_version
  cosmos_offer_type                  = local.cosmos_offer_type
  access_key_metadata_writes_enabled = local.access_key_metadata_writes_enabled
  # is_virtual_network_filter_enabled  = local.isVirtualNetworkFilterEnabled
  public_network_access_enabled = var.resource_config.public_network_access_enabled
  default_identity_type         = local.default_identity_type
  cosmos_backup_type            = var.resource_config.cosmos_backup_type
  cosmos_interval_in_minutes    = local.cosmos_interval_in_minutes
  cosmos_retention_in_hours     = local.cosmos_retention_in_hours
  cosmos_backup_tier            = var.resource_config.cosmos_backup_tier
}


# .............................................................................
#                        Function App Plan
# .............................................................................


# Module for provisioning an App Service Plan
module "app_service_plan" {
  source                       = "../module/azure_app_service"
  app_service_plan_name        = var.resource_config.app_service_plan_name
  tags                         = module.rakbank_tags.tags
  location                     = var.resource_config.location
  resource_group_name          = data.azurerm_resource_group.data_rg.name
  sku_name                     = var.resource_config.asp_sku_name
  zone_balancing_enabled       = var.resource_config.zone_balancing_enabled
  maximum_elastic_worker_count = var.resource_config.maximum_elastic_worker_count
  os_type                      = local.asp_os_type
}


# .............................................................................
#                        Function App
# .............................................................................

# Module for deploying a Linux-based Azure Function App
module "function_app" {
  source     = "../module/linux_function_app"
  depends_on = [module.function_user_assigned_identity, module.function_adls, module.role_assignement]

  name                          = var.resource_config.function_app_name
  tags                          = module.rakbank_tags.tags
  location                      = var.resource_config.location
  rg_name                       = data.azurerm_resource_group.data_rg.name
  asp_id                        = local.asp_id
  function_identity             = local.function_identity
  virtual_network_subnet_id     = local.virtual_network_subnet_id
  https_only                    = local.https_only
  storage_account_name          = local.fa_storage_account_name
  public_network_access_enabled = var.resource_config.public_network_access_enabled
}

# .............................................................................
#                        Disk Encryption
# .............................................................................

# Module for Disk Encryption Set
module "disk_encryption_set" {
  source = "../module/disk_encryption_set"

  # Disk Encryption Set Configuration
  disk_encryption_set_name = local.disk_encryption_set_name
  rg_name                  = var.resource_config.resource_group_name
  location                 = var.resource_config.location
  key_vault_id             = data.azurerm_key_vault_key.kv_key.id
  identity                 = local.des_identity
  tags                     = module.rakbank_tags.tags
}

# .............................................................................
#                        AKS Cluster
# .............................................................................

module "aks" {
  source = "../module/aks"

  # AKS Cluster Configuration
  aks_name                   = var.resource_config.aks_name
  location                   = var.resource_config.location
  rg_name                    = var.resource_config.resource_group_name
  vnet_subnet_id             = data.azurerm_subnet.aks_subnet.id
  log_analytics_workspace_id = ""
  osm_agent_enabled          = false
  authorized_ip_ranges       = []

  # Node Pool Configuration
  node_pool_name          = local.node_pool_name
  local_account_disabled  = local.local_account_disabled
  vm_size                 = local.vm_size
  sku_tier                = local.sku_tier
  private_cluster_enabled = local.private_cluster_enabled

  # Networking Configuration
  dns_prefix     = local.dns_prefix
  network_plugin = local.network_plugin
  network_policy = local.network_policy
  outbound_type  = local.outbound_type

  # OS and Scaling Configuration
  os_sku                          = local.os_sku
  os_disk_size_gb                 = local.os_disk_size_gb
  node_pool_zones                 = var.resource_config.user_node_pool_zones #local.node_pool_zones
  sys_temporary_name_for_rotation = local.sys_temporary_name_for_rotation
  node_count                      = local.node_count
  enable_auto_scaling             = local.enable_auto_scaling
  system_min_count                = local.system_min_count
  system_max_count                = local.system_max_count
  system_max_pods                 = local.system_max_pods

  # Identity and Security
  identity_type                       = local.aks_identity
  aks_tags                            = module.rakbank_tags.tags
  node_resource_group                 = local.node_resource_group
  node_pool                           = local.node_pool
  os_disk_type                        = local.os_disk_type
  private_cluster_public_fqdn_enabled = local.private_cluster_public_fqdn_enabled
  azure_rbac_enabled                  = local.azure_rbac_enabled
  tenant_id                           = data.azurerm_client_config.current.tenant_id

  # Additional Security Features
  automatic_upgrade_channel    = local.automatic_upgrade_channel
  host_encryption_enabled      = local.host_encryption_enabled
  disk_encryption_set_id       = local.disk_encryption_set_id
  secret_rotation_enabled      = local.secret_rotation_enabled
  azure_policy_enabled         = local.azure_policy_enabled
  only_critical_addons_enabled = local.only_critical_addons_enabled

  depends_on = [module.disk_encryption_set, module.role_assignement]
}


# .............................................................................
#                        ACR
# .............................................................................

# Module for Azure Container Registry (ACR)
module "acr" {
  source = "../module/acr"

  # ACR General Configuration
  acr_name = var.resource_config.acr_name
  rg_name  = var.resource_config.resource_group_name
  location = var.resource_config.location
  acr_sku  = var.resource_config.acr_sku

  # Networking and Security
  public_network_access_enabled = var.resource_config.public_network_access_enabled
  zone_redundancy_enabled       = local.zone_redundancy_enabled
  network_rule_bypass_option    = local.network_rule_bypass_option
  default_action                = local.default_action
  geo_replication_enabled       = local.geo_replication_enabled
  acr_tags                      = module.rakbank_tags.tags

  # Policies
  trust_policy_enabled      = local.trust_policy_enabled
  quarantine_policy_enabled = local.quarantine_policy_enabled
  retention_policy_in_days  = local.retention_policy_in_days

  depends_on = [module.aks]
}

# .............................................................................
#                       Document Intelligence
# .............................................................................

# Module for Azure Document Intelligence Service
module "document_intelligence" {
  source                         = "../module/cognitive_account"                     # Path to the Cognitive Account module
  name                           = var.resource_config.di_name                       # Document Intelligence service name
  location                       = data.azurerm_resource_group.data_rg.location      # Deployment location
  rg_name                        = data.azurerm_resource_group.data_rg.name          # Resource group name
  kind                           = local.di_kind                                     # Type of AI Document Intelligence service
  sku_name                       = var.resource_config.di_sku_name                   # SKU tier for the service
  publice_network_access_enabled = var.resource_config.public_network_access_enabled # Public access setting
  custom_subdomain               = var.resource_config.di_custom_subdomain_name      # Custom domain for the service
  cognitive_identity             = local.di_identity                                 # Identity configuration (SystemAssigned)
  local_auth_enabled             = local.di_local_auth_enabled                       # Enables/disables local authentication
  tags                           = module.rakbank_tags.tags                          # Tags for resource tracking
  key_scope_id                   = local.key_role_id
  key_vault_key_id               = local.key_vault_key_id
}


# # .............................................................................
# #                       AI Translator
# # .............................................................................


# Module for Azure AI Translator Service
module "ai_translator" {
  source                         = "../module/cognitive_account"                     # Path to the Cognitive Account module
  name                           = var.resource_config.tr_name                       # Name of the AI Translator service
  kind                           = local.tr_kind                                     # Type of AI Translator service (e.g., Translator, Speech, etc.)
  rg_name                        = data.azurerm_resource_group.data_rg.name          # Resource group name where the service is deployed
  location                       = data.azurerm_resource_group.data_rg.location      # Location/region where the service is deployed
  sku_name                       = var.resource_config.tr_sku_name                   # SKU tier for the Translator service (pricing plan)
  publice_network_access_enabled = var.resource_config.public_network_access_enabled # Specifies if public network access is enabled
  custom_subdomain               = var.resource_config.tr_custom_subdomain_name      # Custom domain name for the Cognitive Service
  cognitive_identity             = local.tr_identity                                 # Identity type (e.g., SystemAssigned, UserAssigned)
  local_auth_enabled             = local.tr_local_auth_enabled                       # Enables/disables local authentication
  tags                           = module.rakbank_tags.tags                          # Tags for resource categorization and tracking
  key_scope_id                   = local.key_role_id
  key_vault_key_id               = local.key_vault_key_id
}

# ..............................................................................
#                             AI Search
# ..............................................................................


# Module for Azure AI Search Service
module "ai_search" {
  source                        = "../module/ai_search"                             # Path to the AI Search module
  ai_search_name                = var.resource_config.ai_search_name                # AI Search service name from AI_Config
  ai_search_sku                 = var.resource_config.ai_search_sku                 # AI Search SKU tier
  ai_search_tag                 = module.rakbank_tags.tags                          # Tags for resource identification
  public_network_access_enabled = var.resource_config.public_network_access_enabled # Enable or disable public access
  ai_service_hosting_mode       = local.ai_service_hosting_mode                     # Hosting mode for the AI Search service
  ai_partition_count            = local.ai_partition_count                          # Number of partitions for indexing
  ai_replica_count              = local.ai_replica_count                            # Number of replicas for redundancy
  ai_search_rg_name             = data.azurerm_resource_group.data_rg.name          # Resource group name
  ai_search_rg_location         = data.azurerm_resource_group.data_rg.location      # Resource group location
  ai_search_identity            = local.ai_search_identity                          # Identity configuration (SystemAssigned)
}

# .............................................................................
#                        Private Endpoints
# .............................................................................


# Deploying Private Endpoints for secure access to Data Lake and Key Vault
module "private_endpoint" {
  source                               = "../module/private_endpoint"
  for_each                             = local.private_endpoint_config
  location                             = var.resource_config.location
  private_connection_resource_id       = each.value.private_connection_resource_id
  private_connection_subresource_names = each.value.private_connection_subresource_names
  custom_network_interface_name        = each.value.custom_nic_name
  private_endpoint_name                = each.value.private_endpoint_name
  private_service_connection_name      = each.value.private_service_connection_name
  resource_group_name                  = data.azurerm_resource_group.data_rg.name
  subnet_endpoint_id                   = each.value.subnet_endpoint_id
  resource_tags                        = module.rakbank_tags.tags

  depends_on = [module.keyvault, module.adls, module.function_adls, module.sql_server, module.cosmos_database
    , module.role_assignement, module.ai_search, module.ai_translator, module.document_intelligence, module.aks, module.acr, module.disk_encryption_set
  , module.app_service_plan]
}
