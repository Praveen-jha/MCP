resource "azurerm_virtual_network_gateway_connection" "s2s_connection" {
  name = var.s2s_connection_name
  type = var.s2s_connection_type
  virtual_network_gateway_id = var.vng_id
  local_network_gateway_id = var.lng_id
  location = var.s2s_connection_location
  resource_group_name = var.s2s_connection_resource_group_name
  shared_key = var.shared_key
  tags = var.connection_tags
}