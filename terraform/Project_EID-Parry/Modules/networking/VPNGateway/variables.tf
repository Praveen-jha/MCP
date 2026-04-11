// REQUIRED VARIABLES (variables which are needed to be passed)
variable "virtual_network_gateway_name" {
  type        = string
  description = "Name of the Azure VPN Gateway"
}
variable "location" {
  description = "The region where the Azure VPN Gateway will be created"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group where the Azure VPN Gateway will be created"
  type        = string
}
variable "gateway_type" {
  description = "Type of the VPN gateway"
  type        = string
}
variable "gateway_sku" {
  description = "SKU of the VPN Gateway"
  type        = string
}
variable "gateway_public_ip_id" {
  description = "The ID of the public IP address associated with the VPN Gateway"
  type        = string
}
variable "gateway_subnet_id" {
  description = "The ID of the subnet associated with the VPN Gateway"
  type        = string
}

// OPTIONAL VARIABLES (variables which are not necessary to be passed)
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}
variable "vpn_type" {
  description = "Type of VPN"
  type        = string
}
variable "active_active" {
  description = "Indicates if active-active mode is enabled for the VPN Gateway"
  type        = bool
}
variable "enable_bgp" {
  description = "Indicates if BGP is enabled for the VPN Gateway"
  type        = bool
}
variable "ip_configuration_name" {
  description = "Name of the IP configuration for the VPN Gateway"
  type        = string
}
variable "private_ip_address_allocation" {
  description = "IP address allocation method"
  type        = string
}