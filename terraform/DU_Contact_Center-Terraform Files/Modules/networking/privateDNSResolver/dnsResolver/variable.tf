variable "dns_resolver_name" {
  description = "Name of the Private DNS Resolver"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the parent resource group"
  type        = string
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the associated virtual network"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
