nameConfig = {
  defaultLocation            = "australia east"
  existingApplicationRGName  = "ngdp1t-application-rg"
  deploymentEnvironment      = "t"
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

cotainers = {
  containerOneName = "rawzone"
  containerTwoName = "curatedzone"
  containerThreeName = "enrichedzone"
}
