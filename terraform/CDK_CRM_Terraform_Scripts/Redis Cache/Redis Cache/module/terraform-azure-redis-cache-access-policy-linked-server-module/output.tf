// output.tf
// This file defines the output values for the azurerm_redis_linked_server module.

output "linked_server" {
  description = "Full Redis linked server object."
  value       = azurerm_redis_linked_server.this
}

output "geo_replicated_primary_host_name" {
  value       = azurerm_redis_linked_server.this.geo_replicated_primary_host_name
  description = "The hostname of the geo-replicated primary Redis instance."
}

output "id" {
  value       = azurerm_redis_linked_server.this.id
  description = "The ID of the Redis linked server resource."
}

output "name" {
  value       = azurerm_redis_linked_server.this.name
  description = "The name of the Redis linked server."
}

output "linked_redis_cache_id" {
  value       = azurerm_redis_linked_server.this.linked_redis_cache_id
  description = "The ID of the linked Redis cache."
}

output "linked_redis_cache_location" {
  value       = azurerm_redis_linked_server.this.linked_redis_cache_location
  description = "The Azure region of the linked Redis cache."
}

output "resource_group_name" {
  value       = azurerm_redis_linked_server.this.resource_group_name
  description = "The name of the resource group for the Redis linked server."
}

output "server_role" {
  value       = azurerm_redis_linked_server.this.server_role
  description = "The role of the linked server, either 'Primary' or 'Secondary'."
}

output "target_redis_cache_name" {
  value       = azurerm_redis_linked_server.this.target_redis_cache_name
  description = "The name of the target Redis cache."
}

output "timeouts" {
  value       = azurerm_redis_linked_server.this.timeouts
  description = "Timeouts block for create, update, and delete operations."
}
