resource "azurerm_route_table" "route_table" {
  name                = var.rt_name
  location            = var.rt_location
  resource_group_name = var.rt_rg_name
  tags                          = var.rt_tags
  dynamic "route" {
    for_each = var.rt_routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}
