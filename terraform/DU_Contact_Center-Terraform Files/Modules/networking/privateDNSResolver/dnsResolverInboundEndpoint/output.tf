output "id" {
  description = "ID of the inbound endpoint"
  value       = azurerm_private_dns_resolver_inbound_endpoint.this.id
}

output "name" {
  description = "Name of the inbound endpoint"
  value       = azurerm_private_dns_resolver_inbound_endpoint.this.name
}
