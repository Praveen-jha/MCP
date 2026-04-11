output "id" {
  description = "ID of the DNS Forwarding Ruleset"
  value       = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
}

output "name" {
  description = "Name of the DNS Forwarding Ruleset"
  value       = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.name
}
