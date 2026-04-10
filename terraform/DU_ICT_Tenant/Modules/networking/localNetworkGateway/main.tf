resource "azurerm_local_network_gateway" "lng" {
  name = var.lng_name
  location = var.lng_location
  resource_group_name = var.lng_resource_group_name
  gateway_address = var.lng_address
  address_space = var.lng_address_space
}