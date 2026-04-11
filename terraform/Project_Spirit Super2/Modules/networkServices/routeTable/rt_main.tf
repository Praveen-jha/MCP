resource "azurerm_route_table" "route_table" {
  name                          = var.rtName
  location                      = var.location
  resource_group_name           = var.rgName
  disable_bgp_route_propagation = var.disableBgpRoutePropagation
  tags                          = var.rtTags
  dynamic "route" {
    for_each = var.rtRoutes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}
