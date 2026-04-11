output "id" {
  description = "ID of the virtual network link"
  value       = azurerm_private_dns_resolver_virtual_network_link.this.id
}

output "name" {
  description = "Name of the virtual network link"
  value       = azurerm_private_dns_resolver_virtual_network_link.this.name
}
