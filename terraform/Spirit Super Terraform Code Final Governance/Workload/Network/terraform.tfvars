nameConfig = {
  defaultLocation            = "australia east"
  existingNetworkRGName      = "ngdp1t-networking-rg"
  deploymentEnvironment      = "test"
  identity                   = "ngdp"
  identity2                  = "platform"
  index                      = 1
  PublicNetworkAccessEnabled = true
  tags = {
    business_owner        = "Technology"
    managed_by            = "terraform"
    source                = ""
  }
}

vnet = {
  existingVnetName                           = "platform1-aue-vnet1"
  privateEndpointSnetAddressPrefixes         = ["10.144.241.0/27"]
  computeSnetAddressPrefixes                 = ["10.144.241.32/27"]
  hostSnetAddressPrefixes                    = ["10.144.241.64/26"]
  contianerSnetAddressPrefixes               = ["10.144.241.128/26"]
  hostTwoSnetAddressPrefixes                 = ["10.144.241.192/28"]
  containerTwoSnetAddressPrefixes            = ["10.144.241.208/28"]
  routes = [
  ]
}