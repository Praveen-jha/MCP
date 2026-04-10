nameConfig = {
  defaultLocation            = "australia east"
  existingNetworkRGName      = "ngdp1t-networking-rg"
  existingVnetName           = "platform1-aue-vnet1"
  existingApplicationRGName  = "ngdp1t-application-rg"
  deploymentEnvironment      = "test"
  identity                   = "ngdp"
  identity2                  = "platform"
  index                      = 1
  publicNetworkAccessEnabled = false
  tags = {
    business_owner = "Technology"
    managed_by     = "terraform"
    source         = ""
  }
}

adlsGen2 = {
  AccountTier            = "Standard"
  AccountReplicationType = "LRS"
  AccountKind            = "StorageV2"
  IsHnsEnabled           = true
}

keyVault = {
  SkuName                   = "standard"
  defaultAction             = "Allow"
  kvBypass                  = "AzureServices"
  ipRules                   = []
  keyVaultSecretContentType = "Password"
  daysToExpire              = 183
}

logAnalyticsWorkspace = {
  sku               = "PerGB2018"
  retention_in_days = 30
}

databricksWorkspace = {
  sku = "premium"
}

synapseWorksapce = {
  sqlAdminUser = "adminuser"
}

privateDNSZoneID = {
  synapseSQLPrivateDNSZoneID         = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.sql.azuresynapse.net"
  synapseSQLOnDemandPrivateDNSZoneID = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.sql.azuresynapse.net"
  synapseDevPrivateDNSZoneID         = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.dev.azuresynapse.net"
  keyVaultPrivateDNSZoneID           = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
  adlsGen2BlobPrivateDNSZoneID       = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
  adlsGen2DfsPrivateDNSZoneID        = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"
  dbUiApiPrivateDNSZoneID            = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azuredatabricks.net"
  dbbrowsAuthPrivateDNSZoneID        = "/subscriptions/41ae3075-2ae0-4d8a-8233-c602b5f8ef28/resourceGroups/private-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azuredatabricks.net"
}
