# ......................................................
# Module: Purview Account
# ......................................................
module "purview_account" {
  source               = "../../Modules/purview/purviewWorkspace"
  purviewName          = "${local.baseName1}-pview01bg"
  resourceGroupName    = data.azurerm_resource_group.data_governance_rg.name
  purviewManagedRGName = "${local.baseName1}-pview-managed-rg"
  publicNetworkEnabled = "Enabled"
  location             = "centralindia"
  tags                 = var.nameConfig.tags
}

# ..............................................................
# Module: Ingestion Blob Private Endpoint for Purview Account
# ..............................................................
module "purview_ingestion_blob_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-pview-ingestion-blob-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.data_governance_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-pview-ingestion-blob-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-pview-ingestion-blob-pe1"
  privateResourceId            = module.purview_account.ingestionStorageID
  subresourceNames             = local.TargetSubresource.purviewIngestionBlobPeSubresourceNames
  dnsZoneGroupName             = "privatednsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = data.azurerm_private_dns_zone.purview_ingestion_blob_private_dns_zone.id
  isManualConnection           = true
  depends_on                   = [module.purview_account]
}

# ............................................................
# Module: Ingestion DFS Private Endpoint for Purview Account
# ............................................................
module "purview_ingestion_queue_pep" {
  count                        = var.nameConfig.publicNetworkAccessEnabled == false ? 1 : 0
  source                       = "../../Modules/networkServices/privateEndpoint"
  peName                       = "${local.baseName1}-pview-ingestion-queue-pe1"
  location                     = var.nameConfig.defaultLocation
  rgName                       = data.azurerm_resource_group.data_governance_rg.name
  peSubnetId                   = data.azurerm_subnet.pe_subnet.id
  peNicName                    = "${local.baseName1}-pview-ingestion-queue-pe1-nic"
  serviceConnectionName        = "${local.baseName1}-pview-ingestion-queue-pe1"
  privateResourceId            = module.purview_account.ingestionStorageID
  subresourceNames             = local.TargetSubresource.purviewIngestionQueuePeSubresourceNames
  dnsZoneGroupName             = "privatednsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = data.azurerm_private_dns_zone.purview_ingestion_dfs_private_dns_zone.id
  isManualConnection           = true
  depends_on                   = [module.purview_account, module.purview_ingestion_blob_pep]
}

module "diagnostic_setting_purview_account" {
  source                  = "../../Modules/diagnosticSettings/purviewDiagnostics"
  dignosticSettingName    = "${local.baseName1}-pview01-ds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/ngdp1t-governance-rg/providers/Microsoft.Purview/accounts/ngdp1test-pview01bg"
  depends_on = [ module.purview_account ]
}