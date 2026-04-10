locals {
  # .............................................................................
  #                        Key Vault
  # .............................................................................

  # Key Vault configurations used to create a Key Vault in an existing resource group
  enabled_for_disk_encryption = true # Enables disk encryption for security
  purge_protection_enabled    = true # Prevents accidental deletion of the Key Vault
  soft_delete_retention_days  = 90   # Retains deleted Key Vault for 90 days, allowing recovery
  enable_rbac_authorization   = true

  key_definitions = {}

  # my_key_tgr1 = {
  #   key_opts                             = ["encrypt", "decrypt", "sign", "verify"]
  #   key_type                             = "RSA"
  #   key_size                             = 2048
  #   available_rotation_policy            = true
  #   rotation_policy_time_before_expiry   = "P30D"
  #   rotation_policy_expire_after         = "P365D"
  #   rotation_policy_notify_before_expiry = "P30D"
  # }

  secret_definitions = {}

  # my_secret_nht1 = {
  #   secret_value = "Praveen"
  # }


  # .............................................................................
  #                        Storage account Common
  # .............................................................................

  storage_account_tier                     = "Standard" # Performance tier for storage
  infrastructure_encryption_enabled        = true       # Enables additional infrastructure encryption
  shared_access_key_enabled                = false      # Disables shared access key authentication for security
  network_rules_ip_rules                   = []         # Defines allowed IP address rules for access
  network_rules_virtual_network_subnet_ids = []         # Defines allowed subnets for virtual network integration
  delete_retention_policy_days             = 30         # Retains deleted data for 30 days before permanent deletion
  min_tls_version                          = "TLS1_2"   # Sets the minimum TLS version for security compliance
  local_user_enabled                       = false      # Disables local users for added security
  is_hns_enabled                           = true       # Indicates whether hierarchical namespace is enabled (for ADLS Gen2)
  key_vault_id                             = data.azurerm_key_vault.kv.id
  # keyVersionlessId                    = data.azurerm_key_vault_key.kv_key.id
  key_name = data.azurerm_key_vault_key.kv_key.name

  # Storage Account Managed Identity Configuration
  storage_account_identity = {
    type         = "SystemAssigned" # Uses a system-assigned managed identity for authentication
    identity_ids = []               # No user-assigned identities specified
  }

  # .............................................................................
  #                        Shared Storage account
  # .............................................................................

  storage_account_name       = var.resource_config.shared_adls_name # Name of the Azure Data Lake Storage (ADLS) account
  storage_account_containers = {}

  # containerA = {
  #   container_name = "container1"
  #   access_type    = "blob"
  # }
  # containerB = {
  #   container_name = "container2"
  #   access_type    = "blob"
  # }

  # .............................................................................
  #                        Function app Storage account
  # ..............................................................................

  fa_storage_account_name       = var.resource_config.function_adls_name # Name of the Azure Data Lake Storage (ADLS) account
  fa_storage_account_containers = {}

  # containerA = {
  #   container_name = "container1"
  #   access_type    = "blob"
  # }
  # containerB = {
  #   container_name = "container2"
  #   access_type    = "blob"
  # }


  # .............................................................................
  #                        SQL Server
  # .............................................................................

  # SQL Server Configuration
  sql_server_version        = "12.0"                                         # Specifies the SQL Server version
  sql_server_admin_password = data.azurerm_key_vault_secret.kv_secrets.value # Admin password (store securely, avoid hardcoding)
  sql_server_admin_login    = "sqlAdmin"                                     # Admin login username
  # Azure Active Directory (Azure AD) administrator for SQL Server
  sql_server_azure_ad_administrator = {
    object_id      = data.azurerm_client_config.current.object_id # Azure AD admin object ID
    login_username = "rakbank"                                    # Azure AD administrator username
  }
  sql_server_min_tls_version = "1.2" # Minimum TLS version for security
  auditing_policy_enabled    = false
  # System-assigned managed identity for SQL Server
  sql_server_identity = {
    type         = "SystemAssigned"
    identity_ids = []
  }

  sql_databases = {
    database1 = {
      database_name              = var.resource_config.sql_db_name
      license_type               = "LicenseIncluded" # SQL database license type (LicenseIncluded or BasePrice)
      max_size_gb                = 250               # Maximum database size in GB
      sku_name                   = "S0"
      enclave_type               = "Default" # Enclave type (Set to None, as no enclave type was specified)
      ledger_enabled             = false     # Disable ledger (as the original input didn't mention enabling it)
      zone_redundant             = false     # Keep zone redundancy disabled (since no change was required)
      secondary_type             = null
      long_term_weekly_retention = "P0W"

    }
  }

  # .............................................................................
  #                                UID names
  # .............................................................................

  # User Assigned Identities for various services
  cosmos_identity_name   = "${var.resource_config.cosmos_db_name}-umi"    # Managed identity for Cosmos DB
  function_identity_name = "${var.resource_config.function_app_name}-umi" # Managed identity for Function App

  # .............................................................................
  #                        Role assignments for various services
  # .............................................................................


  role_assignments = {

    kv_crypto_service_encryption_user_to_cosmosdb_mid = {
      key_scope_id         = data.azurerm_key_vault_key.kv_key.resource_versionless_id
      principle_id         = module.cosmos_user_assigned_identity.identity_principal_id
      role_definition_name = "Key Vault Crypto Service Encryption User"
    }
    storage_blob_data_contributor_to_function_app = {
      key_scope_id         = module.function_adls.storage_account_id
      principle_id         = module.function_user_assigned_identity.identity_principal_id
      role_definition_name = "Storage File Data SMB Share Contributor"
    }
    Kv_crypto_service_encryption_user_to_disk_encryption_set = {
      key_scope_id         = data.azurerm_key_vault_key.kv_key.resource_versionless_id
      principle_id         = module.disk_encryption_set.principal_id
      role_definition_name = "Key Vault Crypto Service Encryption User"
    }
  }


  # .............................................................................
  #                        Cosmos DB Configuration
  # .............................................................................

  # Cosmos DB Configuration
  cosmos_geo_location = {
    location          = "UAE North",
    failover_priority = 0
  }                                         # Geo-replication setup
  cosmos_automatic_failover_enabled = false # Multi-region writes are enabled, so automatic failover is not needed
  # User-assigned managed identity for Cosmos DB
  cosmos_identity = {
    type         = "UserAssigned"
    identity_ids = [module.cosmos_user_assigned_identity.identity_id]
  }
  # Default identity type for Cosmos DB
  default_identity_type = join("=", ["UserAssignedIdentity", module.cosmos_user_assigned_identity.identity_id])
  # Consistency policy for Cosmos DB
  cosmos_consistency_policy = {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }
  cosmos_min_tls_version = "Tls12"    # Minimum TLS version for Cosmos DB
  cosmos_offer_type      = "Standard" # Offer type for Cosmos DB
  # Enable multi-region writes as specified
  # cosmosMultiRegionWritesEnabled = false
  # Provisioned throughput settings
  # cosmosThroughput = 400 # Throughput (RU/s)
  # Disable analytical storage as specified
  # cosmosAnalyticalStorageEnabled = false
  # Continuous backup storage setup
  cosmos_retention_in_hours  = 720
  cosmos_interval_in_minutes = 240
  # Dedicated gateway setting (disabled as per input)
  # cosmosDedicatedGatewayEnabled = false

  # Key Vault Integration for Customer-Managed Key (CMK)

  access_key_metadata_writes_enabled = false # Disable metadata writes for access keys
  # is_virtual_network_filter_enabled  = true


  # .............................................................................
  #                        Function App Plan
  # .............................................................................

  # App Service Plan Configuration
  asp_os_type = "Linux" # OS type for the App Service Plan
  # zone_balancing_enabled = true    # Disable zone balancing


  # .............................................................................
  #                        Function app
  # .............................................................................

  # Function App Configuration
  asp_id                    = module.app_service_plan.app_service_plan_id # Reference to the App Service Plan
  virtual_network_subnet_id = data.azurerm_subnet.integration_subnet.id   # VNet subnet for integration
  https_only                = true                                        # Enforce HTTPS access
  function_identity = {
    type         = "UserAssigned"
    identity_ids = [module.function_user_assigned_identity.identity_id]
  }

  # .............................................................................
  #                        Azure Kubernetes Service (AKS) Configuration
  # .............................................................................
  node_pool_name                  = "syspool"       # Default node pool name
  vm_size                         = "Standard_B2ms" # VM size for AKS nodes
  sku_tier                        = "Standard"      # SKU tier for AKS
  private_cluster_enabled         = true            # Enable/disable private cluster
  dns_prefix                      = "aksprefix"     # DNS prefix for AKS
  network_plugin                  = "azure"         # Network plugin type
  network_policy                  = "azure"         # Network policy
  outbound_type                   = "userDefinedRouting"
  os_sku                          = "Ubuntu"  # OS SKU for AKS nodes
  os_disk_type                    = "Managed" # OS disk type
  os_disk_size_gb                 = 32        # OS disk size in GB
  sys_temporary_name_for_rotation = "${local.node_pool_name}temp"
  node_count                      = 1    # Initial number of nodes in the pool
  enable_auto_scaling             = true # Enable/disable autoscaling
  system_min_count                = 1    # Minimum node count for autoscaling
  system_max_count                = 1    # Maximum node count for autoscaling
  system_max_pods                 = 35   # Maximum number of pods per node
  # identityType                    = "SystemAssigned"                                  # AKS identity type
  private_cluster_public_fqdn_enabled = false                                             # Enable/disable public FQDN for private cluster
  automatic_upgrade_channel           = "stable"                                          # Automatic upgrade channel
  azure_rbac_enabled                  = true                                              # Enable/disable Azure RBAC for AKS
  host_encryption_enabled             = false                                             # Enable/disable host encryption
  disk_encryption_set_id              = module.disk_encryption_set.disk_encryption_set_id # Disk encryption set ID
  secret_rotation_enabled             = true                                              # Enable/disable secret rotation
  azure_policy_enabled                = true                                              # Enable/disable Azure Policy for AKS
  only_critical_addons_enabled        = true                                              # Enable only critical add-ons

  # Additional security settings
  local_account_disabled = true        # Disable local accounts for AKS
  node_resource_group    = "ManagedRG" # Managed resource group for AKS
  aks_identity           = "SystemAssigned"

  # User-defined node pool configuration
  node_pool = {
    user_pool = {
      name                            = "userpool"                               # User node pool name
      mode                            = "User"                                   # Node pool mode (System/User)
      vm_size                         = "Standard_D8as_v5"                       # VM size for user pool
      os_type                         = "Linux"                                  # OS type
      os_sku                          = "Ubuntu"                                 # OS SKU
      os_disk_type                    = "Managed"                                # OS disk type
      os_disk_size_gb                 = 32                                       # OS disk size in GB
      enable_auto_scaling             = true                                     # Enable/disable autoscaling for user pool
      node_count                      = 2                                        # Initial number of nodes
      max_count                       = 2                                        # Maximum node count for autoscaling
      min_count                       = 1                                        # Minimum node count for autoscaling
      zones                           = var.resource_config.user_node_pool_zones # Availability zones
      max_pods                        = 35                                       # Maximum number of pods per node
      host_encryption_enabled         = false                                    # Enable/disable host encryption
      usr_temporary_name_for_rotation = "userpooltemp"
      node_labels = {
        "environment" = "tst"
        "workload"    = "general"
      } # Labels for the node pool
    }
  }

  # .............................................................................
  #                        Azure Disk Encryption Configuration
  # .............................................................................
  disk_encryption_set_name = "${var.resource_config.aks_name}-des" # Name of the disk encryption set
  des_identity = {
    type         = "SystemAssigned" # Assigning a user-assigned identity
    identity_ids = []
  }


  # .............................................................................
  #                        Azure Container Registry (ACR) Configuration
  # .............................................................................
  zone_redundancy_enabled    = false # Enable/disable zone redundancy
  geo_replication_enabled    = false
  network_rule_bypass_option = "AzureServices" # Allow Azure services to bypass network rules
  quarantine_policy_enabled  = true            # Enable/disable quarantine policy for ACR
  default_action             = "Allow"         # Default network rule action (Allow/Deny)
  trust_policy_enabled       = true            # Enable trusted images for security
  retention_policy_in_days   = 30              # Retention period for untagged manifests (in days)


  # .............................................................................
  #                        Document Intelligence
  # .............................................................................

  # Document Intelligence Configuration
  di_identity           = "SystemAssigned" # Assigns a system-managed identity
  di_local_auth_enabled = false            # disable/enable the local authentication methsods for Document Intelligence
  di_kind               = "FormRecognizer" # Type of Document Intelligence service (e.g., FormRecognizer, Emotion)


  # .............................................................................
  #                        AI Translator
  # .............................................................................

  # AI Translator Configuration
  tr_identity           = "SystemAssigned"  # Assigns a system-managed identity
  tr_local_auth_enabled = false             # disable/enable the local authentication methsods for Document Intelligence
  tr_kind               = "TextTranslation" # Type of Translator service (e.g., TextTranslation, DocumentTranslation)



  # .............................................................................
  #                        AI Search
  # .............................................................................

  # AI Search Configuration
  ai_service_hosting_mode = "default"        # Sets the hosting mode for AI Search
  ai_partition_count      = 2                # Defines the number of partitions for AI Search
  ai_search_identity      = "SystemAssigned" # Assigns a system-managed identity
  ai_replica_count        = 2                # Sets the number of replicas for AI Search


  # .............................................................................
  #                        Role assignments for various services
  # .............................................................................
  key_role_id                  = data.azurerm_key_vault_key.kv_key.resource_versionless_id # key id to refer the key for encryption
  key_vault_key_id             = data.azurerm_key_vault_key.kv_key.id
  key_vault_key_versionless_id = data.azurerm_key_vault_key.kv_key.versionless_id # cosmos required versionless id for encryption



  # .............................................................................
  #                        Private endpoint for varioous Services
  # .............................................................................

  # Private Endpoint Configurations for secure network access to resources
  private_endpoint_config = {
    # Private Endpoint for Key Vault
    kv1_endpoint = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name             # Name of the resource group
      private_connection_subresource_names = ["vault"]                                            # Specifies subresource for Key Vault
      private_endpoint_name                = "${var.resource_config.key_vault_name}-vault-ep"     # Private endpoint name
      custom_nic_name                      = "${var.resource_config.key_vault_name}-vault-ep-nic" # Custom NIC name
      private_service_connection_name      = "vault_endpoint"                                     # Name of the private service connection
      private_connection_resource_id       = module.keyvault.key_vault_id                         # Reference to Key Vault ID
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id                # Subnet for private endpoint
      private_dns_zone_ids                 = [""]                                                 # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                                            # Name of the private DNS zone group
    }

    # Private Endpoint for Blob Storage in Data Lake
    shared_blob_endpoint = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name              # Name of the resource group
      private_connection_subresource_names = ["blob"]                                              # Specifies subresource for Blob Storage
      private_endpoint_name                = "${var.resource_config.shared_adls_name}-blob-ep"     # Private endpoint name
      custom_nic_name                      = "${var.resource_config.shared_adls_name}-blob-ep-nic" # Custom NIC name
      private_service_connection_name      = "blob_endpoint"                                       # Name of the private service connection
      private_connection_resource_id       = module.adls.storage_account_id                        # Reference to Storage Account ID
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id                 # Subnet for private endpoint
      private_dns_zone_ids                 = [""]                                                  # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                                             # Name of the private DNS zone group
    }

    # Private Endpoint for DFS Storage in Data Lake
    shred_dfs_endpoint = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name             # Name of the resource group
      private_connection_subresource_names = ["dfs"]                                              # Specifies subresource for DFS Storage
      private_endpoint_name                = "${var.resource_config.shared_adls_name}-dfs-ep"     # Private endpoint name
      custom_nic_name                      = "${var.resource_config.shared_adls_name}-dfs-ep-nic" # Custom NIC name
      private_service_connection_name      = "dfs_endpoint"                                       # Name of the private service connection
      private_connection_resource_id       = module.adls.storage_account_id                       # Reference to Storage Account ID
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id                # Subnet for private endpoint
      private_dns_zone_ids                 = [""]                                                 # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                                            # Name of the private DNS zone group
    }

    sql_db = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name # Name of the resource group
      private_endpoint_name                = "${var.resource_config.sql_server_name}-sql-ep"
      custom_nic_name                      = "${var.resource_config.sql_server_name}-sql-ep-nic"
      private_connection_resource_id       = module.sql_server.sql_server_id
      private_service_connection_name      = "sql-private-connection"
      private_connection_subresource_names = ["sqlServer"]
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id # Subnet for private endpoint
      private_dns_zone_ids                 = [""]                                  # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                             # Name of the private DNS zone group
    }

    #   # Private Endpoint for Cosmos DB
    cosmos_db = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name # Name of the resource group
      private_endpoint_name                = "${var.resource_config.cosmos_db_name}-cosmos-ep"
      custom_nic_name                      = "${var.resource_config.cosmos_db_name}-cosmos-ep-nic"
      private_connection_resource_id       = module.cosmos_database.cosmos_db_id
      private_service_connection_name      = "cosmos-private-connection"
      private_connection_subresource_names = ["Sql"]
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id # Subnet for private endpoint
      private_dns_zone_ids                 = [""]                                  # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                             # Name of the private DNS zone group
    }

    # Private Endpoint for Blob Storage in Data Lake
    fun_blob_endpoint = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name # Name of the resource group
      private_endpoint_name                = "${var.resource_config.function_adls_name}-blob-ep"
      custom_nic_name                      = "${var.resource_config.function_adls_name}-blob-ep-nic"
      private_connection_subresource_names = ["blob"]
      private_service_connection_name      = "blobendpoint"
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id # Subnet for the private endpoint
      private_connection_resource_id       = module.function_adls.storage_account.id

      private_dns_zone_ids        = [""]      # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name = "default" # Name of the private DNS zone group
    }

    # Private Endpoint for DFS Storage in Data Lake
    fun_dfs_endpoint = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name # Name of the resource group
      private_endpoint_name                = "${var.resource_config.function_adls_name}-dfs-ep"
      custom_nic_name                      = "${var.resource_config.function_adls_name}-dfs-ep-nic"
      private_connection_subresource_names = ["dfs"]
      private_service_connection_name      = "dfs-endpoint"
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id # Subnet for the private endpoint
      private_connection_resource_id       = module.function_adls.storage_account.id

      private_dns_zone_ids        = [""]      # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name = "default" # Name of the private DNS zone group
    }

    # Private Endpoint for Function App
    function_app_endpoint = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name # Name of the resource group
      private_endpoint_name                = "${var.resource_config.function_app_name}-fa-ep"
      custom_nic_name                      = "${var.resource_config.function_app_name}-fa-ep-nic"
      private_connection_subresource_names = ["sites"]
      private_service_connection_name      = "function-app-endpoint"
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id # Subnet for the private endpoint
      private_connection_resource_id       = module.function_app.function_app_id
      private_dns_zone_ids                 = [""]      # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default" # Name of the private DNS zone group
    }

    acr = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name     # Resource group name
      private_endpoint_name                = "${var.resource_config.acr_name}-pe"         # Private endpoint name
      custom_nic_name                      = "${var.resource_config.acr_name}-acr-ep-nic" # nic for acr private endpoint
      location                             = data.azurerm_resource_group.data_rg.location # Location of private endpoint
      private_connection_resource_id       = module.acr.acr_id                            # Private connection resource ID
      private_service_connection_name      = "${var.resource_config.acr_name}-pe"         # Private service connection name
      private_connection_subresource_names = ["registry"]                                 # Subresource names
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id        # Subnet for private endpoint
      private_dns_zone_ids                 = [""]                                         # Private DNS zone IDs
      private_dns_zone_group_name          = "default"                                    # Private DNS zone group name
    }

    ai_search = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name      # Name of the resource group
      private_endpoint_name                = "${var.resource_config.ai_search_name}-ai-pe" # Name of the private endpoint
      custom_nic_name                      = "${var.resource_config.ai_search_name}-ai-ep-nic"
      location                             = data.azurerm_resource_group.data_rg.location # Location of the private endpoint
      private_service_connection_name      = "${var.resource_config.ai_search_name}-pe"   # Name of the private connection
      private_connection_resource_id       = module.ai_search.account_id                  # AI Search resource ID
      private_connection_subresource_names = ["searchService"]                            # Subresource name for private connection
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id        # Subnet for the private endpoint
      private_dns_zone_ids                 = [""]                                         # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                                    # Name of the private DNS zone group
    }

    document_intelligence = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name # Name of the resource group
      private_endpoint_name                = "${var.resource_config.di_name}-pe"      # Private endpoint name
      custom_nic_name                      = "${var.resource_config.di_name}-di-ep-nic"
      location                             = data.azurerm_resource_group.data_rg.location # Location of the private endpoint
      private_connection_resource_id       = module.document_intelligence.account_id      # Resource ID of Document Intelligence
      private_service_connection_name      = "${var.resource_config.di_name}-pe"          # Private connection name
      private_connection_subresource_names = ["account"]                                  # Subresource name for private connection
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id        # Subnet for the private endpoint
      private_dns_zone_ids                 = [""]                                         # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                                    # Name of the private DNS zone group
    }

    ai_translator = {
      resource_group_name                  = data.azurerm_resource_group.data_rg.name           # Name of the resource group
      private_endpoint_name                = "${var.resource_config.tr_name}-pe"                # Name of the private endpoint
      custom_nic_name                      = "${var.resource_config.tr_name}-translator-ep-nic" # custom NIC name
      location                             = data.azurerm_resource_group.data_rg.location       # Location of the private endpoint
      private_connection_resource_id       = module.ai_translator.account_id                    # Resource ID of AI Translator
      private_service_connection_name      = "${var.resource_config.tr_name}-pe"                # Name of the private connection
      private_connection_subresource_names = ["account"]                                        # Subresource name for private connection
      subnet_endpoint_id                   = data.azurerm_subnet.private_subnet.id              # Subnet for the private endpoint
      private_dns_zone_ids                 = [""]                                               # DNS zone IDs for private DNS resolution
      private_dns_zone_group_name          = "default"                                          # Name of the private DNS zone group
    }
  }
}
