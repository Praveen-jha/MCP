variable "name" {
  description = "Name of the Private DNS Resolver Virtual Network Link"
  type        = string
}

variable "dns_forwarding_ruleset_id" {
  description = "ID of the DNS Forwarding Ruleset"
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the Virtual Network to link"
  type        = string
}

variable "metadata" {
  description = "Metadata for the virtual network link"
  type        = map(string)
  default     = {}
}
