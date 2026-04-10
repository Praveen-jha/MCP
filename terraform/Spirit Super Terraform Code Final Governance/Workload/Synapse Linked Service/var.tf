variable "nameConfig" {
  type = object({
    defaultLocation            = string
    tags                       = map(string)
    existingApplicationRGName  = string
    deploymentEnvironment      = string
    identity                   = string
    identity2                  = string
    index                      = number
    publicNetworkAccessEnabled = bool
    purviewAccountResourceID   = string
    shirName                   = string
  })
  description = "Variable to Provide Values required for the Deployment, e.g., Location, Tags, Environment,etc."
}
