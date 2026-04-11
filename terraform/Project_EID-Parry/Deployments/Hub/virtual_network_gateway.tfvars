nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "existing"
  environment     = "hub"
  businessunit    = "ea"
  identity        = "eid"
  tags = {
    "Business Owner" = "EID"
    "Business Unit"  = "EA"
    "Environment"    = "Hub"
  }
}

vpnGateway = {
    vpn_type                      = "RouteBased"
    vpn_gw_type                   = "Vpn"
    enable_bgp                    = false
    enable_active_active          = false
    private_ip_address_allocation = "Dynamic"
    gateway_sku                   = "VpnGw1"
}

publicIP = {
    private_ip_address_allocation = "Static"
    pip_sku                       = "Standard"
}

lng = {
    lng_address       = "168.62.225.23"
    lng_address_space = ["10.1.1.0/24"]
}

s2s = {
    s2s_connection_type = "IPsec"
    shared_key          = "key"
}
