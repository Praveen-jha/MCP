variable "private_endpoint_name" {
  description = "Name of the Azure Private Endpoint"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "subnet_endpoint_id" {
  description = "ID of the subnet for the endpoint"
  type        = string
}

variable "private_service_connection_name" {
  description = "Name of the Private Service Connection"
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID for the private connection"
  type        = string
}

variable "private_connection_subresource_names" {
  description = "Names of the subresources for the private connection"
  type        = list(string)
}

variable "is_manual_connection" {
  description = "Boolean indicating if the connection is manual"
  type        = bool
  default     = false
}

variable "private_dns_zone_group_name" {
  description = "Name of the private DNS zone group"
  type        = string
  default     = ""
}

variable "private_dns_zone_ids" {
  description = "IDs of the private DNS zones"
  type        = list(string)
  default     = []
}

variable "custom_network_interface_name" {
  type        = string
  description = "custom interface name for private endpoint"
  nullable    = true
  default     = null
}

variable "resource_tags" {
  type        = map(string)
  description = "resource tags applicable for private endpoint"
}
