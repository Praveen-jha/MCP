nameConfig = {
  defaultLocation              = "australia east"
  existingdataGovernanceRGName = "ngdp1t-governance-rg"
  existingNetworkRGName        = "ngdp1t-networking-rg"
  existingApplicationRGName    = "ngdp1t-application-rg"
  existingVnetName             = "platform1-aue-vnet1"
  deploymentEnvironment        = "test"
  identity                     = "ngdp"
  identity2                    = "platform"
  index                        = 1
  publicNetworkAccessEnabled   = false
  tags = {
    business_owner = "Technology"
    managed_by     = "terraform"
    source         = ""
  }
}
