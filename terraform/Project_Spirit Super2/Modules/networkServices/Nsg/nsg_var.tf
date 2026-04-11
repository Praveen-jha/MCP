variable "nsgName" {
  type        = string
  description = "nsg name"
}

variable "location" {
  type        = string
  description = "The location (region) where the Azure Network Security Group will be created."
}

variable "rgName" {
  type        = string
  description = "The name of the Azure Resource Group where the Network Security Group will be created."
}

variable "nsgTags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Network Security Group."
}


variable "secRule" {
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = string
    destination_port_range       = string
    source_address_prefix        = string
    destination_address_prefix   = string
    source_address_prefixes      = list(string)
    destination_address_prefixes = list(string)
  }))
  description = "nsg rule with attributes."
}
