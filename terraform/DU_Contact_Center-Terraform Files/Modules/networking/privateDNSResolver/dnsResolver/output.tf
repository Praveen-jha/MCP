output "id" {
  description = "Private DNS Resolver ID"
  value       = azurerm_private_dns_resolver.main.id
}

output "name" {
  description = "Private DNS Resolver name"
  value       = azurerm_private_dns_resolver.main.name
}
