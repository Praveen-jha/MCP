variable "name" {
  description = "Name of the DNS Forwarding Ruleset"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "private_dns_resolver_outbound_endpoint_ids" {
  description = "List of outbound endpoint IDs"
  type        = list(string)
}

variable "tags" {
  description = "Tags for the ruleset"
  type        = map(string)
  default     = {}
}
