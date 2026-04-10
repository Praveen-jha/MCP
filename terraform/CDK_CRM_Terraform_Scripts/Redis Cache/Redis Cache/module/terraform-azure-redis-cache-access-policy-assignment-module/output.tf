// output.tf
// This file defines the output values for the azurerm_redis_cache_access_policy_assignment module.

output "redis_cache_access_policy_assignment" {
  description = "Full details of the Redis Cache Access Policy Assignment."
  value       = azurerm_redis_cache_access_policy_assignment.this
}

output "id" {
  description = "ID of the Redis Cache Access Policy Assignment."
  value       = azurerm_redis_cache_access_policy_assignment.this.id
}

output "redis_cache_id" {
  description = "ID of the Redis Cache which is being used."
  value       = azurerm_redis_cache_access_policy_assignment.this.redis_cache_id
}

output "name" {
  description = "Name of the policy assignment."
  value       = azurerm_redis_cache_access_policy_assignment.this.name
}

output "object_id" {
  description = "Assigned object ID."
  value       = azurerm_redis_cache_access_policy_assignment.this.object_id
}

output "object_id_alias" {
  description = "Alias of the assigned object ID."
  value       = azurerm_redis_cache_access_policy_assignment.this.object_id_alias
}

output "access_policy_name" {
  description = "Access Policy Name assigned."
  value       = azurerm_redis_cache_access_policy_assignment.this.access_policy_name
}

output "timeouts" {
  description = "Timeout configuration block for the Redis cache access policy assignment."
  value       = azurerm_redis_cache_access_policy_assignment.this.timeouts
}

