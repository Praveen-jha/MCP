variable "nameConfig" {
  type = object({
    defaultLocation              = string
    tags                         = map(string)
    existingdataGovernanceRGName = string
    existingNetworkRGName        = string
    existingApplicationRGName    = string
    existingVnetName             = string
    deploymentEnvironment        = string
    identity                     = string
    identity2                    = string
    index                        = number
    publicNetworkAccessEnabled   = bool
  })
  description = "Variable to Provide Values required for the Deployment, e.g., Location, Tags, Environment,etc."
}
