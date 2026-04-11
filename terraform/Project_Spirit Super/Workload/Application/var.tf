variable "nameConfig" {
  type = object({
    defaultLocation            = string
    tags                       = map(string)
    existingNetworkRGName      = string
    existingVnetName           = string
    existingApplicationRGName  = string
    deploymentEnvironment      = string
    identity                   = string
    identity2                  = string
    index                      = number
    publicNetworkAccessEnabled = bool
  })
  description = "Variable to Provide Values required for the Deployment, e.g., Location, Tags, Environment,etc."
}

variable "adlsGen2" {
  type = object({
    AccountTier            = string
    AccountReplicationType = string
    AccountKind            = string
    IsHnsEnabled           = bool
  })
  description = "Properties of ADLS Gen 2."
}

variable "keyVault" {
  type = object({
    SkuName                   = string
    defaultAction             = string
    kvBypass                  = string
    ipRules                   = list(string)
    keyVaultSecretContentType = string
    daysToExpire              = number
  })
  description = "Properties of Key Vault."
}

variable "logAnalyticsWorkspace" {
  type = object({
    sku               = string
    retention_in_days = number
  })
  description = "Properties of Log Analytics Workspace."
}

variable "databricksWorkspace" {
  type = object({
    sku = string
  })
  description = "Properties of Azure Databricks."
}

variable "privateDNSZoneID" {
  type = object({
    synapseSQLPrivateDNSZoneID         = string
    synapseSQLOnDemandPrivateDNSZoneID = string
    synapseDevPrivateDNSZoneID         = string
    keyVaultPrivateDNSZoneID           = string
    adlsGen2BlobPrivateDNSZoneID       = string
    adlsGen2DfsPrivateDNSZoneID        = string
    dbUiApiPrivateDNSZoneID            = string
    dbbrowsAuthPrivateDNSZoneID        = string
  })
  description = "Private DNS Zones Resource IDS."
}

variable "synapseWorksapce" {
  type = object({
    sqlAdminUser = string
  })
  description = "Properties of Azure Synapse Analytics Workspace."
}
