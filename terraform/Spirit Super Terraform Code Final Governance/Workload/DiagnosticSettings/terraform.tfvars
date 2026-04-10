nameConfig = {
  defaultLocation            = "australia east"
  existingApplicationRGName  = "ngdp1t-application-rg"
  deploymentEnvironment      = "t"
  identity                   = "ngdp"
  identity2                  = "platform"
  index                      = 1
  publicNetworkAccessEnabled = false
  purviewAccountResourceID   = "/subscriptions/2aa0f3d8-42c4-41fa-b03e-c19b09f6ce8c/resourceGroups/ngdp1t-governance-rg/providers/Microsoft.Purview/accounts/ngdp1t-pview"
  tags = {
    business_owner = "Technology"
    managed_by     = "terraform"
    source         = "tf-diagnostics-pipeline"
  }
}
