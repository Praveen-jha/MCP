variable "subnetName" {
  type = string
  description = "subnet name for new subnet"
}

variable "rgName" {
  type        = string
  description = "The name of the Azure Resource Group where the Subnet will be created."
}

variable "subnetAddressPrefixes" {
  type        = list(string)
  description = "The address prefixes for the Azure Compute Subnet."
}

variable "virtualNetworkName" {
  type        = string
  description = "The name of the Azure Virtual Network where the Subnet will be created."
}

variable "privateEndpointNetworkPoliciesEnabled" {
  type        = bool
  description = "Indicates whether network policies are enabled for private endpoints on this subnet."
  default = false
}

variable "privateLinkServiceNetworkPoliciesEnabled" {
  type        = bool
  description = "Indicates whether network policies are enabled for private link service on this subnet."
  default = false
}

# variable "serviceEndpoints" {
#   type        = list(string)
#   description = "The list of service endpoints to associate with the Azure Subnet."
# }

variable "subnetDelegations" {
  type = any 
  description = "Object of subnet delegations for the Azure Subnet."
}
variable "nsgId" {
  type = string
  description = "The ID of the Network Security Group which should be associated with the Subnet."
}

variable "rtId" {
  type = string
  description = "The ID of the Route Table which should be associated with the Subnet."
}

variable "subnet_nsg_association" {
  type = bool
  description = "Condition to associate network security group with the subnet. "
}

variable "subnet_rt_association" {
  type = bool
  description = "Condition to associate route table with the subnet."
}