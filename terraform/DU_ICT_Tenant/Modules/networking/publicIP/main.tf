resource "azurerm_public_ip" "vpn_gw_pip" {
  name = var.pip_name
  allocation_method = var.pip_allocation_method
  sku = var.pip_sku
  resource_group_name = var.resource_group_name
  location = var.location
  tags = var.pip_tags
}