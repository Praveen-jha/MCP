// output.tf
// This file defines the output values for the azurerm_redis_cache_access_policy module.

output "redis_cache_access_policy" {
  description = "Full output of the Redis Cache Access Policy resource."
  value       = azurerm_redis_cache_access_policy.this
}

output "id" {
  description = "The ID of the Redis Cache Access Policy."
  value       = azurerm_redis_cache_access_policy.this.id
}

output "name" {
  description = "Name of the access policy."
  value       = azurerm_redis_cache_access_policy.this.name
}

output "permissions" {
  description = "List of permissions granted."
  value       = azurerm_redis_cache_access_policy.this.permissions
}

output "redis_cache_id" {
  description = "ID of the Redid cache."
  value       = azurerm_redis_cache_access_policy.this.redis_cache_id
}