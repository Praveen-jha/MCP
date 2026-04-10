resource "azurerm_virtual_network_gateway" "virtualNetworkGateway" {
  name                = var.virtual_network_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.gateway_type
  vpn_type            = var.vpn_type
  active_active       = var.active_active
  enable_bgp          = var.enable_bgp
  sku                 = var.gateway_sku
  tags                = var.tags
  ip_configuration {
    name                          = var.ip_configuration_name
    public_ip_address_id          = var.gateway_public_ip_id
    private_ip_address_allocation = var.private_ip_address_allocation
    subnet_id                     = var.gateway_subnet_id
  }
  lifecycle {
    prevent_destroy = true
  }
}