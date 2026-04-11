output "id" {
  description = "ID of the forwarding rule"
  value       = azurerm_private_dns_resolver_forwarding_rule.this.id
}

output "name" {
  description = "Name of the forwarding rule"
  value       = azurerm_private_dns_resolver_forwarding_rule.this.name
}
