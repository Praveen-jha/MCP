# ......................................................
# Module: Key Vault
# ......................................................
module "key_vault" {
  source                       = "../../Modules/keyVault/keyVault"
  keyVaultName                 = "${local.baseName1}-kv01bw"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  bypass                       = var.keyVault.kvBypass
  defaultAction                = var.keyVault.defaultAction
  enabledForDeployment         = true
  enabledForTemplateDeployment = true
  enableRbacAuthorization      = true
  kvEnabledForDiskEncryption   = true
  kvIpRules                    = var.keyVault.ipRules
  kvPurgeProtectionEnabled     = false
  kvSoftDeleteRetentionDays    = 7
  kvSkuName                    = var.keyVault.SkuName
  publicNetworkAccessEnabled   = var.nameConfig.publicNetworkAccessEnabled
  kvTags                       = var.nameConfig.tags
}

# ......................................................
# Resource: Random Password
# ......................................................
resource "random_password" "sql_admin_password" {
  length  = 14
  special = true
  lower   = true
  numeric = true
  upper   = true
}

# ......................................................
# Module: Key Vault Secret
# ......................................................
resource "azurerm_key_vault_secret" "sql_admin_password_kv_secret" {
  name            = "sql-admin-password"
  value           = random_password.sql_admin_password.result
  key_vault_id    = module.key_vault.kvId
  content_type    = var.keyVault.keyVaultSecretContentType
  expiration_date = local.expirationDate
}

# ......................................................
# Module: Vault Private Endpoint for Key Vault
# ......................................................
module "key_vault_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-kv-vault-pe1bw"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-kv-vault-pe1a-nic"
  serviceConnectionName        = "${local.baseName1}-kv-vault-pe1a"
  privateResourceId            = module.key_vault.kvId
  subresourceNames             = local.TargetSubresource.keyVaultPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-kv-vault-pe1a-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.keyVaultPrivateDNSZoneID
  depends_on                   = [random_password.sql_admin_password, module.synapse_workspace]
}

# ......................................................
# Module: Logic App
# ......................................................
module "logic_app" {
  source            = "../../Modules/logicApp"
  logicAppName      = "${local.baseName1}-logicbw"
  location          = var.nameConfig.defaultLocation
  resourceGroupName = data.azurerm_resource_group.application_rg.name
  tags              = var.nameConfig.tags
}

# ......................................................
# Module: Storage Account
# ......................................................
module "adls_gen2" {
  source                     = "../../Modules/storageServices/storageAccount"
  storageAccountName         = "${local.baseName1}dlsbw"
  rgName                     = data.azurerm_resource_group.application_rg.name
  location                   = var.nameConfig.defaultLocation
  accountKind                = var.adlsGen2.AccountKind
  accountReplicationType     = var.adlsGen2.AccountReplicationType
  accountTier                = var.adlsGen2.AccountTier
  isHnsEnabled               = var.adlsGen2.IsHnsEnabled
  networkRules               = local.networkRulesNull
  publicNetworkAccessEnabled = true
  tags                       = var.nameConfig.tags
}

# ......................................................
# Module: Storage Account File System
# ......................................................
module "adls_gen2_file_system" {
  source           = "../../Modules/storageServices/adlsGen2FileSystem"
  fileSystemName   = "${local.baseName1}dls-filesystem1"
  storageAccountId = module.adls_gen2.storageAccountId
}

# ......................................................
# Module: Storage Account Network Rules
# ......................................................
module "sa_network" {
  source           = "../../Modules/storageServices/storageAccountNetworking"
  storageAccountID = module.adls_gen2.storageAccountId
  defaultAction    = "Deny"
  depends_on = [
    module.adls_gen2_file_system
  ]
}

# ......................................................
# Module: Blob Private Endpoint for Storage Account
# ......................................................
module "adls_gen2_blob_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-dls-blob-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-dls-blob-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-dls-blob-pe1"
  privateResourceId            = module.adls_gen2.storageAccountId
  subresourceNames             = local.TargetSubresource.adlsGen2BlobPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-dls-blob-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.adlsGen2BlobPrivateDNSZoneID
  depends_on                   = [module.adls_gen2_file_system, module.sa_network]
}

# ......................................................
# Module: DFS Private Endpoint for Storage Account
# ......................................................
module "adls_gen2_dfs_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-dls-dfs-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-dls-dfs-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-dls-dfs-pe1"
  privateResourceId            = module.adls_gen2.storageAccountId
  subresourceNames             = local.TargetSubresource.adlsGen2DfsPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-dls-dfs-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.adlsGen2DfsPrivateDNSZoneID
  depends_on                   = [module.adls_gen2_blob_pep]
}

# ......................................................
# Module: Storage Account
# ......................................................
module "adls_gen2_second" {
  source                     = "../../Modules/storageServices/storageAccount"
  storageAccountName         = "${local.baseName1}dls2bw"
  rgName                     = data.azurerm_resource_group.application_rg.name
  location                   = var.nameConfig.defaultLocation
  accountKind                = var.adlsGen2.AccountKind
  accountReplicationType     = var.adlsGen2.AccountReplicationType
  accountTier                = var.adlsGen2.AccountTier
  isHnsEnabled               = var.adlsGen2.IsHnsEnabled
  networkRules               = local.networkRulesNull
  publicNetworkAccessEnabled = var.nameConfig.publicNetworkAccessEnabled
  tags                       = var.nameConfig.tags
}

# ......................................................
# Module: Blob Private Endpoint for Storage Account
# ......................................................
module "adls_gen2_second_blob_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-dls2-blob-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-dls2-blob-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-dls2-blob-pe1"
  privateResourceId            = module.adls_gen2_second.storageAccountId
  subresourceNames             = local.TargetSubresource.adlsGen2BlobPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-dls2-blob-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.adlsGen2BlobPrivateDNSZoneID
}

# ......................................................
# Module: DFS Private Endpoint for Storage Account
# ......................................................
module "adls_gen2_second_dfs_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-dls2-dfs-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-dls2-dfs-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-dls2-dfs-pe1"
  privateResourceId            = module.adls_gen2_second.storageAccountId
  subresourceNames             = local.TargetSubresource.adlsGen2DfsPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-dls2-dfs-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.adlsGen2DfsPrivateDNSZoneID
  depends_on                   = [module.adls_gen2_blob_pep]
}

# ......................................................
# Module: Synapse Analytics Workspace
# ......................................................
module "synapse_workspace" {
  source                       = "../../Modules/synapse/synapseWorkspace"
  synapseWorkspaceName         = "${local.baseName1}-synwbw"
  rgName                       = data.azurerm_resource_group.application_rg.name
  location                     = var.nameConfig.defaultLocation
  publicNetworkAccessEnabled   = var.nameConfig.publicNetworkAccessEnabled
  managedVirtualNetworkEnabled = true
  fileSystemId                 = module.adls_gen2_file_system.fileSystemID
  sqlAdminUserName             = var.synapseWorksapce.sqlAdminUser
  sqlAdminPassword             = azurerm_key_vault_secret.sql_admin_password_kv_secret.value
  tags                         = var.nameConfig.tags
  depends_on                   = [random_password.sql_admin_password]
}

# ..............................................................
# Module: SQL Private Endpoint for Synapse Analytics Workspace
# ..............................................................
module "synapse_sql_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-synw-sql-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-synw-sql-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-synw-sql-pe1"
  privateResourceId            = module.synapse_workspace.synapseWorkspaceId
  subresourceNames             = local.TargetSubresource.synapseSQLPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-synw-sql-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.synapseSQLPrivateDNSZoneID
}

# ........................................................................
# Module: SQL On Demand Private Endpoint for Synapse Analytics Workspace
# ........................................................................
module "synapse_sql_on_demand_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-synw-sqlondemand-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-synw-sqlondemand-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-synw-sqlondemand-pe1"
  privateResourceId            = module.synapse_workspace.synapseWorkspaceId
  subresourceNames             = local.TargetSubresource.SynapseSQLOnDemandPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-synw-sqlondemand-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.synapseSQLOnDemandPrivateDNSZoneID
  depends_on                   = [module.synapse_sql_pep]
}

# ..............................................................
# Module: Dev Private Endpoint for Synapse Analytics Workspace
# ..............................................................
module "synapse_dev_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-synw-dev-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-synw-dev-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-synw-dev-pe1"
  privateResourceId            = module.synapse_workspace.synapseWorkspaceId
  subresourceNames             = local.TargetSubresource.synapseDevPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-synw-dev-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.synapseDevPrivateDNSZoneID
  depends_on                   = [module.synapse_sql_on_demand_pep]
}

# ......................................................
# Module: Log Analytics Workspace
# ......................................................
module "log_analytics_workspace" {
  source             = "../../Modules/logAnalyticsWorkspace"
  logWorkspaceName   = "${local.baseName1}-logbw"
  location           = var.nameConfig.defaultLocation
  logRetentionInDays = var.logAnalyticsWorkspace.retention_in_days
  logWorkspaceSku    = var.logAnalyticsWorkspace.sku
  rgName             = data.azurerm_resource_group.application_rg.name
  tags               = var.nameConfig.tags
}

# ......................................................
# Module: Azure Databricks Workspace
# ......................................................
module "databricks_workspace" {
  source                      = "../../Modules/databricks/databricksWorkspace"
  databricksName              = "${local.baseName1}-dbwbw"
  resourceGroupName           = data.azurerm_resource_group.application_rg.name
  location                    = var.nameConfig.defaultLocation
  databricksNoPublicIp        = true
  databricksPrivateNSGId      = data.azurerm_network_security_group.container_nsg.id
  databricksPrivateSubnetName = data.azurerm_subnet.databricks_container_subnet.name
  databricksPublicNSGId       = data.azurerm_network_security_group.host_nsg.id
  databricksPublicSubnetName  = data.azurerm_subnet.databricks_host_subnet.name
  databricksVnetId            = data.azurerm_virtual_network.existing_vnet.id
  databricksSku               = var.databricksWorkspace.sku
  publicNetworkAccessEnabled  = var.nameConfig.publicNetworkAccessEnabled
  tags                        = var.nameConfig.tags
}

# ..........................................................
# Module: UI-API Private Endpoint for Databricks Workspace
# ..........................................................
module "databricks_ui_api_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-dbw-uiapi-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-dbw-uiapi-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-dbw-uiapi-pe1"
  privateResourceId            = module.databricks_workspace.databricksWorkspaceId
  subresourceNames             = local.TargetSubresource.dbUiApiPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-dbw-uiapi-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.dbUiApiPrivateDNSZoneID
}

# ..........................................................................
# Module: Browser Authentication Private Endpoint for Databricks Workspace
# ..........................................................................
module "databricks_brows_auth_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-dbw-browsauth-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.application_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-dbw-browsauth-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-dbw-browsauth-pe1"
  privateResourceId            = module.databricks_workspace.databricksWorkspaceId
  subresourceNames             = local.TargetSubresource.dbbrowsAuthPeSubresourceNames
  dnsZoneGroupName             = "${local.baseName1}-dbw-browsauth-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = var.privateDNSZoneID.dbbrowsAuthPrivateDNSZoneID
  depends_on                   = [module.databricks_ui_api_pep]
}

# ......................................................
# Module: Azure Databricks Access Connector
# ......................................................
module "databricks_access_connector" {
  source                        = "../../Modules/databricks/databricksAccessConnector"
  databricksAccessConnectorName = "${local.baseName1}-dbwaccbw"
  location                      = var.nameConfig.defaultLocation
  rgName                        = data.azurerm_resource_group.application_rg.name
  tags                          = var.nameConfig.tags
}
