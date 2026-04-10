variable "nameConfig" {
  type = object({
    defaultLocation                = string
    tags                           = map(string)
    existingNetworkRGName          = string
    existingVnetName               = string
    existingApplicationRGName      = string
    deploymentEnvironment          = string
    identity                       = string
    identity2                      = string
    index                          = number
    publicNetworkAccessEnabled     = bool
  })
}

variable "adlsGen2" {
  type = object({
    AccountTier                = string
    AccountReplicationType     = string
    AccountKind                = string
    IsHnsEnabled               = bool
  })
}

variable "keyVault" {
  type = object({
    SkuName                    = string
    defaultAction              = string
    kvBypass                   = string
    ipRules                    = list(string)
  })
}

variable "logAnalyticsWorkspace" {
  type = object({
    sku                 = string
    retention_in_days   = number
  })
}

variable "databricksWorkspace" {
  type = object({
    sku                 = string
  })
}

variable "privateDNSZoneID" {
  type = object({
    synapseSQLPrivateDNSZoneID              = string
    synapseSQLOnDemandPrivateDNSZoneID      = string
    synapseDevPrivateDNSZoneID              = string
    keyVaultPrivateDNSZoneID                = string
    adlsGen2BlobPrivateDNSZoneID            = string
    adlsGen2DfsPrivateDNSZoneID             = string
    dbUiApiPrivateDNSZoneID                 = string
    dbbrowsAuthPrivateDNSZoneID             = string
  })
}