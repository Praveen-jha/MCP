#Location of VPN Gateway
variable "vpngw_location" {
  type = string
  description = "Location of VPNGW"
}

#Type of VPN
variable "vpn_type" {
  type        = string
  description = "The type of VPN"
}

#Type of VPN Gateway
variable "vpn_gw_type" {
  type        = string
  description = "The type of VPN Gateway"
}

#Bool value to enable or disable BGP
variable "enable_bgp" {
  type        = bool
  description = "Bool value to enable or disable BGP"
}

#Bool value to enable or disable active-active
variable "enable_active_active" {
  type        = bool
  description = "Bool value to enable or disable active-active"
}

#Variable to define allocation method of public IP
variable "pip_allocation_method" {
  type        = string
  description = "Allocation method of public IP"
}

#Variable SKU of VPN gateway
variable "gateway_sku" {
  type        = string
  description = "SKU of VPN gateway"
}

#variable to define private ip allocation for VPN gateway
variable "private_ip_address_allocation" {
  type        = string
  description = "VPN Gateway private ip address allocation"
}

# Variable to define tags for the VPN Gateway
variable "vpngw_tags" {
  type        = map(string)
  description = "A map of tags to assign to the vpngw."
}

#Variable to define public IP sku
variable "pip_sku" {
  type        = string
  description = "SKU of PIP"
}

#Variable to define tags for public IP
variable "pip_tags" {
  type = map(string)
  description = "Tags for public IP"
}

# variable "lng_address" {
#   type        = string
#   description = "Address of HUB LNG"
# }

# variable "lng_address_space" {
#   type        = list(string)
#   description = "Address space of HUB LNG"
# }

# variable "s2s_connection_type" {
#   type        = string
#   description = "Type of s2s connection"
# }

# variable "shared_key" {
#   type        = string
#   description = "Shared key for connection"
# }

# # Variable to define tags for the Local Network Gateway
# variable "lng_tags" {
#   type        = map(string)
#   description = "A map of tags to assign to the lng."
# }

# # Variable to define tags for the VPN Gateway
# variable "connection_tags" {
#   type        = map(string)
#   description = "A map of tags to assign to the S2S connection."
# }