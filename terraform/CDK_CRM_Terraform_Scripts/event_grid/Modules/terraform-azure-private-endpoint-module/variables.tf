// output.tf
// This file defines the output values for the azurerm_private_endpoint module.

variable "private_endpoint_name" {
  description = "The name of the Private Endpoint."
  type        = string
}

variable "location" {
  description = "The Azure location where the Private Endpoint will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the Private Endpoint."
  type        = string
}

variable "custom_network_interface_name" {
  description = "Custom name for the network interface."
  type        = string
  default     = null
}

variable "private_service_connection_name" {
  description = "The name of the private service connection."
  type        = string
}

variable "is_manual_connection" {
  description = "Whether the private endpoint connection is manual."
  type        = bool
  default     = false
}

variable "private_connection_resource_id" {
  description = "The resource ID for the private connection."
  type        = string
}

variable "private_connection_resource_alias" {
  description = "The resource alias for the private connection."
  type        = string
  default     = null
}

variable "subresource_names" {
  description = "A list of subresource names."
  type        = list(string)
}

variable "request_message" {
  description = "A message for manual approval requests."
  type        = string
  default     = null
}

variable "ip_configuration" {
  description = "List of IP configuration blocks for Private Endpoint"
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = optional(string)
    member_name        = optional(string)
  }))
  default = []
}

variable "enable_private_dns_zone_group" {
  description = "Whether to enable the private DNS zone group."
  type        = bool
  default     = false
}

variable "private_dns_zone_group_name" {
  description = "The name of the private DNS zone group."
  type        = string
  default     = null
}

variable "private_dns_zone_ids" {
  description = "A list of private DNS zone IDs."
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = null
}
