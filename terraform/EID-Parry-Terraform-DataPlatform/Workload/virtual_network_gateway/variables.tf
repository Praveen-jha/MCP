# Variables for Hub Network Workload
variable "nameConfig" {
  type = object({
    defaultLocation = string      //Location for the Resource to be Deployed.
    tags            = map(string) //"Tags are key-value pairs that help organize and manage resources by categorizing them (e.g., by environment, department, or purpose)."
    rg_creation     = string      //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    environment     = string      //Deployment Environment (for example UAT or Prod).
    businessunit    = string      //Workload type of the resource
    identity        = string      //Flag to use in Naming Convention
  })
}

variable "vpnGateway" {
  type = object({
    vpn_type                      = string //The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased. 
    vpn_gw_type                   = string //The type of the Virtual Network Gateway. Valid options are Vpn or ExpressRoute.
    enable_bgp                    = bool   //If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. Defaults to false.
    enable_active_active          = bool   //If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance SKU. If false, an active-standby gateway will be created. Defaults to false.
    private_ip_address_allocation = string //Defines how the private IP address of the gateways virtual interface is assigned. The only valid value is Dynamic for Virtual Network Gateway (Static is not supported by the service yet). Defaults to Dynamic.
    gateway_sku                   = string //Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments.
  })
}

variable "publicIP" {
  type = object({
    private_ip_address_allocation = string //Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    pip_sku                       = string //The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard
  })
}

variable "lng" {
  type = object({
    lng_address       = string       //The gateway IP address to connect with.
    lng_address_space = list(string) //The list of string CIDRs representing the address spaces the gateway exposes.
  })
}


variable "s2s" {
  type = object({
    s2s_connection_type = string //The type of connection. Valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet). 
    shared_key          = string //The shared IPSec key. A key could be provided if a Site-to-Site, VNet-to-VNet or ExpressRoute connection is created.
  })
}
