// output.tf
// This file defines the output values for the azurerm_redis_firewall_rule module.

output "redis_firewall_rule" {
  description = "Full output of the Redis Firewall Rule resource."
  value       = azurerm_redis_firewall_rule.this
}

output "id" {
  description = "The ID of the Redis Firewall Rule."
  value       = azurerm_redis_firewall_rule.this.id
}

output "name" {
  description = "Name of the firewall rule."
  value       = azurerm_redis_firewall_rule.this.name
}

output "start_ip" {
  description = "Start IP address of the firewall rule."
  value       = azurerm_redis_firewall_rule.this.start_ip
}

output "end_ip" {
  description = "End IP address of the firewall rule."
  value       = azurerm_redis_firewall_rule.this.end_ip
}

output "resource_group_name" {
  description = "Resource group of the Redis Cache."
  value       = azurerm_redis_firewall_rule.this.resource_group_name
}

output "redis_cache_name" {
  description = "Redis Cache name associated with the firewall rule."
  value       = azurerm_redis_firewall_rule.this.redis_cache_name
}
