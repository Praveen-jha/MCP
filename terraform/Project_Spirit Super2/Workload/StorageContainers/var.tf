variable "nameConfig" {
  type = object({
    defaultLocation                = string
    tags                           = map(string)
    existingApplicationRGName      = string
    deploymentEnvironment          = string
    identity                       = string
    identity2                      = string
    index                          = number
    publicNetworkAccessEnabled     = bool
  })
}

variable "cotainers" {
  type = object({
    containerOneName       = string
    containerTwoName       = string
    containerThreeName     = string
  })
}
