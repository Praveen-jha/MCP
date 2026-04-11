# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the subscription
variable "subscription_id" {
  type        = string
  description = "The name of the subscription_id"
}

# Variable for the Business unit name
variable "bu_name" {
  type        = string
  description = "The name of the Business unit."
}

# Variable for the location shortname name
variable "location_shortname" {
  type        = string
  description = "Variable for the location shortname name."
}

# The geographical location where the resource group will be deployed.
variable "location" {
  type        = string
  description = "Location of the resource group."
}

# Variable to define the address space for the virtual network
variable "address_space_vnet" {
  type        = list(string)
  description = "The address space for the virtual network."
}

# Custom DNS value for the Azure Virtual Network
variable "dns_server" {
  type        = list(string)
  description = "Custom DNS value for Azure Virtual Network "
}

# Variable to define tags for the virtual network
variable "vnet_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual network."
}

# Variable to define common tags for the resources
variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources."
}

# Variable to define the address prefixes for the ml subnet
# variable "subnet_ml_address_prefix" {
#   type        = list(string)
#   description = "A list of address prefixes for the ML subnet."
# }

# Variable to define the address prefixes for the APIM subnet
variable "subnet_apim_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the APIM subnet."
}

# Variable to define the address prefixes for the private endpoint subnet
variable "subnet_pep_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the private endpoint subnet."
}

# Variable to define the address prefixes for the compute subnet
variable "subnet_compute_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the compute subnet."
}

# Determines whether the subnet should be associated with a route table.
# Set to true to enable route table association for the subnet.
variable "subnet_routetable_association" {
  type        = bool
  description = "Boolean flag to enable or disable the subnet's association with a route table."
}

# Determines whether the subnet should be associated with a network security group.
# Set to true to enable NSG association for the subnet.
variable "subnet_nsg_association" {
  type    = bool
  default = true
}

# Determines whether the subnet should be associated with a route table.
# Set to true to enable route table association for the subnet.
variable "subnet_apim_routetable_association" {
  type        = bool
  description = "Boolean flag to enable or disable the subnet's association with a route table."
}

# Determines whether the subnet should be associated with a network security group.
# Set to true to enable NSG association for the subnet.
variable "subnet_apim_nsg_association" {
  type    = bool
  default = true
}

#Hub Subscription ID variable
variable "hub_subscription_id" {
  type        = string
  description = "It is used to pass the Hub Subscription id"
}

#HUB Vnet ID
variable "hub_vnet_id" {
  type        = string
  description = "VNet ID of HUB virtual network"
}

#HUB resource group name
variable "hub_rg_name" {
  type        = string
  description = "Resource group name of Hub"
}

#HUB virtual network name
variable "hub_vnet_name" {
  type        = string
  description = "Virtual network name of Hub"
}

#Spoke Subscription ID ID Variable
variable "spoke_subscription_id" {
  type        = string
  description = "It is used to pass the Spoke Subscription id"
}

#Route Table tags to be associated with Route table.
variable "rt_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}

#NSG tags to be associated with network security group.
variable "nsg_tags" {
  type        = map(string)
  description = "A map of tags to apply to the network security group."
}

variable "apim_public_ip" {
  type = object({
    allocation_method = string
    sku               = string
    domain_name_label = string
    tags              = map(string)
  })
}
