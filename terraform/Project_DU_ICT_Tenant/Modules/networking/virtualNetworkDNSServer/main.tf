resource "azurerm_virtual_network_dns_servers" "name" {
  virtual_network_id = var.virtual_network_id
  dns_servers = var.custom_dns_ip
}