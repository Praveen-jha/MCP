#=======================================
#Create VPN Gateway
#=======================================

module "vpngw" {
  source                        = "../../../Modules/networking/VPNGateway"
  resource_group_name           = data.azurerm_resource_group.hub_network_resource_group.name
  virtual_network_gateway_name  = local.vpngw_name
  vpn_type                      = var.vpn_type
  enable_bgp                    = var.enable_bgp
  active_active                 = var.enable_active_active
  ip_configuration_name         = local.ip_configuration_name
  gateway_subnet_id             = data.azurerm_subnet.vpngw_subnet.id
  gateway_public_ip_id          = module.pip_vpn.public_ip_id
  gateway_sku                   = var.gateway_sku
  gateway_type                  = var.vpn_gw_type
  private_ip_address_allocation = var.private_ip_address_allocation
  location                      = var.vpngw_location
  tags                          = var.vpngw_tags
  depends_on                    = [module.pip_vpn]
}

# ......................................................
# Creation of VPN Gateway PIP
# ......................................................

module "pip_vpn" {
  source                = "../../../Modules/networking/publicIP"
  pip_name              = local.vpngw_pip_name
  pip_allocation_method = var.pip_allocation_method
  pip_sku               = var.pip_sku
  resource_group_name   = data.azurerm_resource_group.hub_network_resource_group.name
  location              = var.vpngw_location
  pip_tags              = var.pip_tags
}

# # ......................................................
# # Creation of local network gateway
# # ......................................................

# module "lng" {
#   source                  = "../../../Modules/networking/localNetworkGateway"
#   lng_name                = local.lng_name
#   lng_resource_group_name = data.azurerm_resource_group.hub_network_resource_group.name
#   lng_location            = var.vpngw_location
#   lng_address             = var.lng_address
#   lng_address_space       = var.lng_address_space
#   lng_tags                = var.lng_tags
# }

# # ......................................................
# # Creation of S2S Connection
# # ......................................................

# module "s2s_connection" {
#   source                             = "../../../Modules/networking/connection"
#   s2s_connection_name                = local.s2s_connection_name
#   s2s_connection_location            = var.vpngw_location
#   s2s_connection_resource_group_name = data.azurerm_resource_group.hub_network_resource_group.name
#   s2s_connection_type                = var.s2s_connection_type
#   shared_key                         = var.shared_key
#   vng_id                             = module.vpngw.vpnGatewayId
#   lng_id                             = module.lng.lng_id
#   connection_tags                    = var.connection_tags
#   depends_on                         = [module.lng, module.vpngw]
# }
