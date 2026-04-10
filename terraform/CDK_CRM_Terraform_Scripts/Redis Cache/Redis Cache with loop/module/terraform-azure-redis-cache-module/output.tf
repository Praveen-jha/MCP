// output.tf
// This file defines the output values for the azurerm_redis_cache module.

output "redis_cache" {
  description = "Full Redis Cache resource object."
  value       = azurerm_redis_cache.this
}

output "redis_cache_id" {
  description = "The ID of the Redis Cache resource."
  value       = azurerm_redis_cache.this.id
}

output "hostname" {
  description = "The hostname of the Redis Cache."
  value       = azurerm_redis_cache.this.hostname
}

output "ssl_port" {
  description = "The SSL port of the Redis instance."
  value       = azurerm_redis_cache.this.ssl_port
}

output "port" {
  description = "The non-SSL port of the Redis instance."
  value       = azurerm_redis_cache.this.port
}

output "primary_access_key" {
  description = "Primary access key for the Redis instance."
  value       = azurerm_redis_cache.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key for the Redis instance."
  value       = azurerm_redis_cache.this.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "Primary connection string."
  value       = azurerm_redis_cache.this.primary_connection_string
}

output "secondary_connection_string" {
  description = "Secondary connection string."
  value       = azurerm_redis_cache.this.secondary_connection_string
}

output "redis_configuration" {
  description = "Redis configuration block output."
  value       = azurerm_redis_cache.this.redis_configuration
}
