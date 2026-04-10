variable "name" {
  description = "Name of the Private DNS Resolver Outbound Endpoint"
  type        = string
}

variable "private_dns_resolver_id" {
  description = "ID of the Private DNS Resolver"
  type        = string
}

variable "location" {
  description = "Azure location for the outbound endpoint"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the outbound endpoint"
  type        = string
}

variable "tags" {
  description = "Tags for the outbound endpoint"
  type        = map(string)
  default     = {}
}
