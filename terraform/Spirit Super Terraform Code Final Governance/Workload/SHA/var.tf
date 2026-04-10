variable "nameConfig" {
  type = object({
    defaultLocation            = string
    tags                       = map(string)
    existingComputeRGName      = string
    existingNetworkRGName      = string
    existingVnetName           = string
    deploymentEnvironment      = string
    identity                   = string
    identity2                  = string
    index                      = number
    publicNetworkAccessEnabled = bool
  })
}

variable "dshaVM" {
  type = object({
    vmSize                            = string
    caching                           = string
    storageAccountType                = string
    availabilityzone                  = list(string)
    publisher                         = string
    offer                             = string
    sku                               = string
    version                           = string
    NIC_ip_configuration              = string
    NIC_private_ip_address_allocation = string
  })
}

