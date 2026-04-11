variable "s2s_connection_name" {
  type = string
  description = "Name of s2s connection"
}

variable "s2s_connection_type" {
  type = string
  description = "Type of s2s connection"
}

variable "vng_id" {
  type = string
  description = "Virtual network gateway ID"
}

variable "s2s_connection_location" {
  type = string
  description = "Location of s2s connection"
}

variable "s2s_connection_resource_group_name" {
  type = string
  description = "Resource group name of s2s connection"
}

variable "lng_id" {
  type = string
  description = "ID of local network gateway"
}

variable "shared_key" {
  type = string
  description = "Shared key for connection"
}

variable "connection_tags" {
  type = map(string)
  description = "Tags for S2S connection"
}