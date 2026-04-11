resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  provider = azurerm.spoke
  name                         = var.peering_name_spoke_to_hub
  resource_group_name          = var.spoke_rg_name
  virtual_network_name         = var.spoke_vnet_name
  remote_virtual_network_id    = var.hub_vnet_id
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_virtual_network_access = var.allow_virtual_network_access

}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  provider = azurerm.hub
  name                         = var.peering_name_hub_to_spoke
  resource_group_name          = var.hub_rg_name
  virtual_network_name         = var.hub_vnet_name
  remote_virtual_network_id    = var.spoke_vnet_id
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_virtual_network_access = var.allow_virtual_network_access
}
