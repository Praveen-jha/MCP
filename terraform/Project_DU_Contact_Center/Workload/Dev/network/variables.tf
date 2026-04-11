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

# Variable to define tags for the RG
variable "resource_group_tags" {
  type        = map(string)
  description = "A map of tags to assign to the RG."
}

# # Variable to define the address prefixes for private endpoint subnet
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

# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "workload_type" {
  type        = string
  description = "workload type of the resource"
}

# Variable for the location name
variable "location_shortname" {
  type        = string
  description = "The geographical location of the resource."
}

# List of custom DNS IP addresses to be used for virtual network.
variable "custom_dns_ip" {
  type        = list(string)
  description = "Custom DNS value for virtual network custom dns."
}


# #Route Table tags to be associated with Route table.
variable "rt_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}

# NSG tags to be associated with subnet.
variable "nsg_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}


 #Hub Subscription ID variable
variable "hub_subscription_id" {
  type = string
  description = "It is used to pass the Hub Subscription id"
}

#Spoke Subscription ID ID Variable
variable "dev_subscription_id" {
  type = string
  description = "It is used to pass the Spoke Subscription id"
}

#Spoke Vnet ID Variable
variable "hub_vnet_id" {
  type = string
  description = ""
}

#Spoke RG Name Variable
variable "hub_rg_name" {
  type = string
  description = " "
}

#Spoke Vnet Variable
variable "hub_vnet_name" {
  type = string
  description = " "
}