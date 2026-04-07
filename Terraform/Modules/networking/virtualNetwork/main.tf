resource "azurerm_virtual_network" "virtual_network" {
  name                = var.new_virtual_network_name
  location            = var.virtual_network_location
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network_address_space
  dns_servers         = var.virtual_network_dns_server
  tags                = var.virtual_network_tags
  lifecycle {
    ignore_changes = [
      # address_space,
      # subnet,
      # dns_servers,
      # tags
    ]
  }
}