# Variable to define the address space for the virtual network
variable "address_space_vnet" {
  type        = list(string)
  description = "The address space for the virtual network."
}

# Variable to define tags for the virtual network
variable "vnet_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual network."
}

# Variable to define the address prefixes for subnet 1
variable "snet1_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the first subnet."
}

# Variable to define the address prefixes for the compute subnet
variable "subnet_compute_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the compute subnet."
}

# Variable to define the address prefixes for subnet 2
variable "subnet2_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the second subnet."
}

# Variable to define the address prefixes for private endpoint subnet
variable "subnet_pep_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the second subnet."
}

# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
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

# The resource ID of the Hub virtual network.
# This is used for referencing the Hub VNet in various configurations, such as peering and routing.
variable "hub_vnet_id" {
  type        = string
  description = "The resource ID of the Hub virtual network."
}

# The name of the resource group that contains the Hub virtual network.
# This is used to manage and organize related Azure resources.
variable "hub_rg_name" {
  type        = string
  description = "The name of the resource group that contains the Hub virtual network."
}

# The name of the Hub virtual network in Azure.
# It is used for network configurations and peering with other VNets.
variable "hub_vnet_name" {
  type        = string
  description = "The name of the Hub virtual network in Azure."
}

# Custom DNS value for the Azure Virtual Network
variable "dns_server" {
  type        = list(string)
  description = "Custom DNS value for Azure Virtual Network "
}

#Hub Subscription ID variable
variable "hub_subscription_id" {
  type = string
  description = "It is used to pass the Hub Subscription id"
}

#Spoke Subscription ID ID Variable
variable "spoke_subscription_id" {
  type = string
  description = "It is used to pass the Spoke Subscription id"
}

# Variable to define tags for the NSGs
variable "nsg_tags" {
  type        = map(string)
  description = "A map of tags to assign to the nsg."
}

#Route Table tags to be associated with Route table.
variable "rt_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}

# Variable to define the address prefixes for subnet 
variable "subnet_mohap_python_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the second subnet."
}