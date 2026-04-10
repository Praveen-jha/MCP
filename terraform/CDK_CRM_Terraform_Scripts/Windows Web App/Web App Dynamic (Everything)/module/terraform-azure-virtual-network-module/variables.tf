// variables.tf
// This file defines the input variables for the azurerm_virtual_network module.

variable "virtual_network_name" {
  description = "The name of the Virtual Network."
  type        = string
}

variable "virtual_network_location" {
  description = "The Azure region where the Virtual Network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Virtual Network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "A list of address prefixes that is used for the Virtual Network (e.g., [\"10.0.0.0/16\"])."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the Virtual Network."
  type        = map(string)
  default     = {}
}

variable "dns_servers" {
  description = "A list of IP addresses of DNS servers to assign to the Virtual Network. Set to null or an empty list if not required."
  type        = list(string)
  default     = null
}

variable "bgp_community" {
  description = "The BGP Community assigned to the Virtual Network. Set to null if not required."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "Specifies the Edge Zone in which the Virtual Network should be created. Set to null if not required."
  type        = string
  default     = null
}

variable "flow_timeout_in_minutes" {
  description = "The flow timeout in minutes for the Virtual Network. Set to null if not required."
  type        = number
  default     = null
}

variable "private_endpoint_vnet_policies" {
  description = "Controls if Private Endpoint Network Policies are enabled on the Virtual Network. Possible values are 'Enabled', 'Disabled'. Set to null if not required."
  type        = string
  default     = null
}

variable "ddos_protection_plan_id" {
  description = "The ID of the DDoS Protection Plan to associate with the Virtual Network. Set to null or an empty string to not associate."
  type        = string
  default     = null
}

variable "enable_ddos_protection_plan" {
  description = "Should the DDoS Protection Plan be enabled if an ID is provided? Only relevant if ddos_protection_plan_id is set."
  type        = bool
  default     = false
}

variable "encryption_enforcement" {
  description = "The enforcement level for VNet encryption. Possible values are 'AllowUnencrypted' or 'DropUnencrypted'. Set to null or an empty string to not configure encryption."
  type        = string
  default     = null
}
