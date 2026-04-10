variable "peering_name_hub_to_spoke" {
  type        = string
  description = "The name of the virtual network peering from the Hub network to the Spoke network."
}

variable "peering_name_spoke_to_hub" {
  type        = string
  description = "The name of the virtual network peering from the Spoke network to the Hub network."
}

variable "spoke_rg_name" {
  type        = string
  description = "The name of the resource group where the Spoke virtual network is deployed."
}

variable "spoke_vnet_name" {
  type        = string
  description = "The name of the Spoke virtual network in Azure."
}

variable "hub_vnet_id" {
  type        = string
  description = "The resource ID of the Hub virtual network, used for creating peering connections."
}

variable "hub_rg_name" {
  type        = string
  description = "The name of the resource group where the Hub virtual network is deployed."
}

variable "hub_vnet_name" {
  type        = string
  description = "The name of the Hub virtual network in Azure."
}

variable "spoke_vnet_id" {
  type        = string
  description = "The resource ID of the Spoke virtual network, used for creating peering connections."
}

variable "allow_virtual_network_access" {
  type = bool
  description = "it give permissions to the virtual network to access the remote virtual network"
}

variable "allow_forwarded_traffic" {
  type = bool
  description = "It allows the virtual network to forward the network traffic"
}

variable "hub_subscription_id" {
  type = string
  description = "It is used to pass the Hub Subscription id"
}

variable "spoke_subscription_id" {
  type = string
  description = "It is used to pass the Spoke Subscription id"
}