variable "rtName" {
  type = string
}

variable "location" {
  type        = string
  description = "The location (region) where the Azure Route Table will be created."
}

variable "rgName" {
  type        = string
  description = "The name of the Azure Resource Group where the Route Table will be created."
}

variable "disableBgpRoutePropagation" {
  type        = bool
  description = "Indicates whether BGP route propagation is disabled."
  default = false
}

variable "rtTags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}

variable "rtRoutes" {
  description = "List of routes for the Azure Route Table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
}
