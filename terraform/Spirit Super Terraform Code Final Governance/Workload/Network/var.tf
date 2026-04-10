variable "nameConfig" {
  type = object({
    defaultLocation            = string
    tags                       = map(string)
    existingNetworkRGName      = string
    deploymentEnvironment      = string
    identity                   = string
    identity2                  = string
    index                      = number
    PublicNetworkAccessEnabled = bool
  })
}

variable "vnet" {
  type = object({
    existingVnetName                       = string
    privateEndpointSnetAddressPrefixes     = list(string)
    computeSnetAddressPrefixes             = list(string)
    hostSnetAddressPrefixes                = list(string)
    contianerSnetAddressPrefixes           = list(string)
    hostTwoSnetAddressPrefixes             = list(string)
    containerTwoSnetAddressPrefixes        = list(string)
    routes = list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    }))
  })
}