# ......................................................
# Module: Key Vault
# ......................................................
# module "keyVault" {
#   source = "../../Modules/keyVault/keyVault"
#   keyVaultName = "${local.baseName1}-kv01bg"
#   location = var.nameConfig.defaultLocation
#   rgName = data.azurerm_resource_group.applicationRG.name 
#   bypass = var.keyVault.kvBypass
#   defaultAction = var.keyVault.defaultAction 
#   enabledForDeployment = true 
#   enabledForTemplateDeployment = true  
#   enableRbacAuthorization =  true
#   kvEnabledForDiskEncryption =  true
#   kvIpRules = var.keyVault.ipRules
#   kvPurgeProtectionEnabled = false
#   kvSoftDeleteRetentionDays =  7
#   kvSkuName = var.keyVault.SkuName
#   publicNetworkAccessEnabled = true
#   kvTags = var.nameConfig.tags
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "sqlAdminuserKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "sqlAdminuser"
#   secretValue =  "adminuser"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault ]
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "sqlAdminPasswordKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "sqlAdminPassword"
#   secretValue =  "password@123"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault, module.sqlAdminuserKvSecret ]
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "synapseShirVMUsernameKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "synapseSHIRVMUsername"
#   secretValue =  "adminuser"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault ,moduel.sqlAdminPasswordKvSecret]
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "synapseShirVMPasswordKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "synapseSHIRVMPassword"
#   secretValue =  "password@123"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault, module.synapseShirVMUsernameKvSecret ]
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "opdgVMUsernameKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "opdgVMUsername"
#   secretValue =  "adminuser"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault ,moduel.synapseShirVMPasswordKvSecret]
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "opdgVMPasswordKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "opdgVMPassword"
#   secretValue =  "password@123"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault, module.opdgVMUsernameKvSecret ]
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "purviewShirVMUsernameKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "purviewShirVMUsername"
#   secretValue =  "adminuser"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault ,moduel.opdgVMPasswordKvSecret]
# }


# # ......................................................
# # Module: Key Vault Secret
# # ......................................................
# module "purviewShirVMPasswordKvSecret" {
#   source = "../../Modules/keyVault/secret"
#   secretName =  "purviewShirVMPassword"
#   secretValue =  "password@123"
#   kvId =  module.keyVault.kvId
#   depends_on = [ module.keyVault, module.purviewShirVMUsernameKvSecret ]
# }


# ......................................................
# Module: Vault Private Endpoint for Key Vault
# ......................................................
# module "keyVaultPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-kv-vault-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name  
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-kv-vault-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-kv-vault-pe1"
#   privateResourceId             = module.keyVault.kvId
#   subresourceNames              = local.TargetSubresource.keyVaultPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-kv-vault-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.keyVaultPrivateDNSZoneID
#   depends_on                    = [module.keyVault]
# }




# # ......................................................
# # Module: Logic App
# # ......................................................
# module "logicApp" {
#   source = "../../Modules/logicApp"
#   logicAppName = "${local.baseName1}-logicbg"
#   location =  var.nameConfig.defaultLocation
#   resourceGroupName = data.azurerm_resource_group.applicationRG.name
#   tags = var.nameConfig.tags
# }


# # ......................................................
# # Module: Storage Account
# # ......................................................
# module "adlsGen2" {
#   source = "../../Modules/storageServices/storageAccount"
#   storageAccountName = "${local.baseName1}dlsbg" 
#   rgName =  data.azurerm_resource_group.applicationRG.name
#   location =  var.nameConfig.defaultLocation
#   accountKind =  var.adlsGen2.AccountKind
#   accountReplicationType =  var.adlsGen2.AccountReplicationType
#   accountTier = var.adlsGen2.AccountTier 
#   isHnsEnabled = var.adlsGen2.IsHnsEnabled
#   networkRules = local.networkRulesNull 
#   publicNetworkAccessEnabled =  true
#   tags = var.nameConfig.tags
# }

# # ......................................................
# # Module: Storage Account File System
# # ......................................................
# module "aldsGen2FileSystem" {
#   source = "../../Modules/storageServices/adlsGen2FileSystem"
#   fileSystemName =  "${local.baseName1}dls-filesystem1"
#   storageAccountId = module.adlsGen2.storageAccountId 
#   depends_on = [ module.adlsGen2 ]
# }

# # ......................................................
# # Module: Storage Account Network Rules
# # ......................................................
# module "saNetwork" {
#   source = "../../Modules/storageServices/storageAccountNetworking"
#   storageAccountID = module.adlsGen2.storageAccountId  
#   defaultAction = "Deny"
#   depends_on = [ 
#     module.aldsGen2FileSystem
#    ]
# }


# # ......................................................
# # Module: Blob Private Endpoint for Storage Account
# # ......................................................
# module "adlsGen2BlobPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-dls-blob-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name 
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-dls-blob-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-dls-blob-pe1"
#   privateResourceId             = module.adlsGen2.storageAccountId
#   subresourceNames              = local.TargetSubresource.adlsGen2BlobPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-dls-blob-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.adlsGen2BlobPrivateDNSZoneID
#   depends_on                    = [module.adlsGen2,module.aldsGen2FileSystem,module.saNetwork]
# }


# # ......................................................
# # Module: DFS Private Endpoint for Storage Account
# # ......................................................
# module "adlsGen2DfsPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-dls-dfs-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name 
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-dls-dfs-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-dls-dfs-pe1"
#   privateResourceId             = module.adlsGen2.storageAccountId
#   subresourceNames              = local.TargetSubresource.adlsGen2DfsPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-dls-dfs-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.adlsGen2DfsPrivateDNSZoneID
#   depends_on                    = [module.adlsGen2, module.adlsGen2BlobPEP]
# }


# # ......................................................
# # Module: Storage Account
# # ......................................................
# module "adlsGen2Second" {
#   source = "../../Modules/storageServices/storageAccount"
#   storageAccountName = "${local.baseName1}dls2bg"
#   rgName =  data.azurerm_resource_group.applicationRG.name
#   location =  var.nameConfig.defaultLocation
#   accountKind =  var.adlsGen2.AccountKind
#   accountReplicationType =  var.adlsGen2.AccountReplicationType
#   accountTier = var.adlsGen2.AccountTier 
#   isHnsEnabled = var.adlsGen2.IsHnsEnabled
#   networkRules = local.networkRulesNull 
#   publicNetworkAccessEnabled = var.nameConfig.publicNetworkAccessEnabled
#   tags = var.nameConfig.tags
# }


# # ......................................................
# # Module: Blob Private Endpoint for Storage Account
# # ......................................................
# module "adlsGen2SecondBlobPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-dls2-blob-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name 
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-dls2-blob-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-dls2-blob-pe1"
#   privateResourceId             = module.adlsGen2Second.storageAccountId
#   subresourceNames              = local.TargetSubresource.adlsGen2BlobPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-dls2-blob-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.adlsGen2BlobPrivateDNSZoneID
#   depends_on                    = [module.adlsGen2Second]
# }


# # ......................................................
# # Module: DFS Private Endpoint for Storage Account
# # ......................................................
# module "adlsGen2SecondDfsPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-dls2-dfs-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name 
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-dls2-dfs-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-dls2-dfs-pe1"
#   privateResourceId             = module.adlsGen2Second.storageAccountId
#   subresourceNames              = local.TargetSubresource.adlsGen2DfsPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-dls2-dfs-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.adlsGen2DfsPrivateDNSZoneID
#   depends_on                    = [module.adlsGen2Second, module.adlsGen2SecondBlobPEP]
# }


# # ......................................................
# # Module: Synapse Analytics Workspace
# # ......................................................
# module "synapseWorkspace" {
#   source = "../../Modules/synapse/synapseWorkspace"
#   synapseWorkspaceName = "${local.baseName1}-synwbg"
#   rgName = data.azurerm_resource_group.applicationRG.name
#   location = var.nameConfig.defaultLocation
#   publicNetworkAccessEnabled =  var.nameConfig.publicNetworkAccessEnabled
#   managedVirtualNetworkEnabled = true
#   fileSystemId = module.aldsGen2FileSystem.fileSystemID
#   sqlAdminUserName = "sqladmin"
#   sqlAdminPassword = "password@123"
#   tags =  var.nameConfig.tags
#   depends_on = [ module.adlsGen2 , module.aldsGen2FileSystem,module.keyVault,module.keyVaultPEP]
# }


# # ..............................................................
# # Module: SQL Private Endpoint for Synapse Analytics Workspace
# # ..............................................................
# module "synapseSQLPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-synw-sql-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name 
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-synw-sql-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-synw-sql-pe1"
#   privateResourceId             = module.synapseWorkspace.synapseWorkspaceId
#   subresourceNames              = local.TargetSubresource.synapseSQLPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-synw-sql-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.synapseSQLPrivateDNSZoneID
#   depends_on                    = [module.synapseWorkspace]
# }


# # ........................................................................
# # Module: SQL On Demand Private Endpoint for Synapse Analytics Workspace
# # ........................................................................
# module "synapseSQLOnDemandPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-synw-sqlondemand-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name  
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-synw-sqlondemand-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-synw-sqlondemand-pe1"
#   privateResourceId             = module.synapseWorkspace.synapseWorkspaceId
#   subresourceNames              = local.TargetSubresource.SynapseSQLOnDemandPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-synw-sqlondemand-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.synapseSQLOnDemandPrivateDNSZoneID
#   depends_on                    = [module.synapseWorkspace,module.synapseSQLPEP]
# }


# # ..............................................................
# # Module: Dev Private Endpoint for Synapse Analytics Workspace
# # ..............................................................
# module "synapseDevPEP" {
#   count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
#   source                        = "../../Modules/networkServices/privateEndpoint"
#   peName                        = "${local.baseName1}-synw-dev-pe1"
#   location                      = var.nameConfig.defaultLocation
#   rgName                        = data.azurerm_resource_group.applicationRG.name  
#   peSubnetId                    = data.azurerm_subnet.peSubnet.id
#   peNicName                     = "${local.baseName1}-synw-dev-pe1-nic"
#   serviceConnectionName         = "${local.baseName1}-synw-dev-pe1"
#   privateResourceId             = module.synapseWorkspace.synapseWorkspaceId
#   subresourceNames              = local.TargetSubresource.synapseDevPeSubresourceNames
#   dnsZoneGroupName              = "${local.baseName1}-synw-dev-pe1-dnsgroup"
#   privateDnsZoneGroupCondition  = true
#   privateDnsZoneIds             = var.privateDNSZoneID.synapseDevPrivateDNSZoneID
#   depends_on                    = [module.synapseWorkspace,module.synapseSQLOnDemandPEP]
# }


# # ......................................................
# # Module: Log Analytics Workspace
# # ......................................................
# module "logAnalyticsWorkspace" {
#   source = "../../Modules/logAnalyticsWorkspace"
#   logWorkspaceName = "${local.baseName1}-logbg" 
#   location = var.nameConfig.defaultLocation 
#   logRetentionInDays = var.logAnalyticsWorkspace.retention_in_days
#   logWorkspaceSku = var.logAnalyticsWorkspace.sku 
#   rgName = data.azurerm_resource_group.applicationRG.name 
#   tags = var.nameConfig.tags
# }


# ......................................................
# Module: Azure Databricks Workspace
# ......................................................
module "databricksWorkspace" {
  source = "../../Modules/databricks/databricksWorkspace"
  databricksName = "${local.baseName1}-dbwbg11" 
  resourceGroupName = data.azurerm_resource_group.applicationRG.name  
  location = var.nameConfig.defaultLocation
  databricksNoPublicIp = true 
  databricksPrivateNSGId = data.azurerm_network_security_group.containerNsg.id 
  databricksPrivateSubnetName = data.azurerm_subnet.databricksContainerSubnet.name
  databricksPublicNSGId = data.azurerm_network_security_group.hostNsg.id 
  databricksPublicSubnetName = data.azurerm_subnet.databricksHostSubnet.name
  databricksVnetId = data.azurerm_virtual_network.existingVnet.id 
  databricksSku = var.databricksWorkspace.sku 
  publicNetworkAccessEnabled = var.nameConfig.publicNetworkAccessEnabled
  tags = var.nameConfig.tags
}


# ..........................................................
# Module: UI-API Private Endpoint for Databricks Workspace
# ..........................................................
module "databricksUiApiPEP" {
  count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                        = "../../Modules/networkServices/privateEndpoint"
  peName                        = "${local.baseName1}-dbw-uiapi-pe1"
  location                      = var.nameConfig.defaultLocation
  rgName                        = data.azurerm_resource_group.applicationRG.name  
  peSubnetId                    = data.azurerm_subnet.peSubnet.id
  peNicName                     = "${local.baseName1}-dbw-uiapi-pe1-nic"
  serviceConnectionName         = "${local.baseName1}-dbw-uiapi-pe1"
  privateResourceId             = module.databricksWorkspace.databricksWorkspaceId
  subresourceNames              = local.TargetSubresource.dbUiApiPeSubresourceNames
  dnsZoneGroupName              = "${local.baseName1}-dbw-uiapi-pe1-dnsgroup"
  privateDnsZoneGroupCondition  = true
  privateDnsZoneIds             = var.privateDNSZoneID.dbUiApiPrivateDNSZoneID
  depends_on                    = [module.databricksWorkspace]
}


# ..........................................................................
# Module: Browser Authentication Private Endpoint for Databricks Workspace
# ..........................................................................
module "databricksBrowsAuthPEP" {
  count                         = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                        = "../../Modules/networkServices/privateEndpoint"
  peName                        = "${local.baseName1}-dbw-browsauth-pe1"
  location                      = var.nameConfig.defaultLocation
  rgName                        = data.azurerm_resource_group.applicationRG.name  
  peSubnetId                    = data.azurerm_subnet.peSubnet.id
  peNicName                     = "${local.baseName1}-dbw-browsauth-pe1-nic"
  serviceConnectionName         = "${local.baseName1}-dbw-browsauth-pe1"
  privateResourceId             = module.databricksWorkspace.databricksWorkspaceId
  subresourceNames              = local.TargetSubresource.dbbrowsAuthPeSubresourceNames
  dnsZoneGroupName              = "${local.baseName1}-dbw-browsauth-pe1-dnsgroup"
  privateDnsZoneGroupCondition  = true
  privateDnsZoneIds             = var.privateDNSZoneID.dbbrowsAuthPrivateDNSZoneID
  depends_on                    = [module.databricksWorkspace,module.databricksUiApiPEP]
}


# ......................................................
# Module: Azure Databricks Access Connector
# ......................................................
# module "databricksAccessConnector" {
#   source = "../../Modules/databricks/databricksAccessConnector"
#   databricksAccessConnectorName = "${local.baseName1}-dbwaccbg"  
#   location =  var.nameConfig.defaultLocation
#   rgName =  data.azurerm_resource_group.applicationRG.name
#   tags = var.nameConfig.tags
# }