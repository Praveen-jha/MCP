output "id" {
  description = "ID of the outbound endpoint"
  value       = azurerm_private_dns_resolver_outbound_endpoint.this.id
}

output "name" {
  description = "Name of the outbound endpoint"
  value       = azurerm_private_dns_resolver_outbound_endpoint.this.name
}
