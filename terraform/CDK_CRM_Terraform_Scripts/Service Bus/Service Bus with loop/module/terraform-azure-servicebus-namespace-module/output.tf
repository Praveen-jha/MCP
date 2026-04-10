#outputs.tf
# Outputs key attributes of the Azure Service Bus Namespace, including connection strings, capacity, and configuration details.

output "servicebus_namespace" {
  description = "Full object representation of the Azure Service Bus Namespace."
  value       = azurerm_servicebus_namespace.this
}

output "capacity" {
  value       = azurerm_servicebus_namespace.this.capacity
  description = "The capacity of the Service Bus namespace."
}

output "default_primary_connection_string" {
  value       = azurerm_servicebus_namespace.this.default_primary_connection_string
  description = "The default primary connection string for the namespace."
}

output "default_primary_key" {
  value       = azurerm_servicebus_namespace.this.default_primary_key
  description = "The default primary key for the namespace authorization rule."
}

output "default_secondary_connection_string" {
  value       = azurerm_servicebus_namespace.this.default_secondary_connection_string
  description = "The default secondary connection string for the namespace."
}

output "default_secondary_key" {
  value       = azurerm_servicebus_namespace.this.default_secondary_key
  description = "The default secondary key for the namespace authorization rule."
}

output "endpoint" {
  value       = azurerm_servicebus_namespace.this.endpoint
  description = "The endpoint for the Service Bus namespace."
}

output "namespace_id" {
  value       = azurerm_servicebus_namespace.this.id
  description = "The ID of the Service Bus namespace."
}

output "local_auth_enabled" {
  value       = azurerm_servicebus_namespace.this.local_auth_enabled
  description = "Indicates if local authentication is enabled."
}

output "location" {
  value       = azurerm_servicebus_namespace.this.location
  description = "The Azure location where the namespace exists."
}

output "minimum_tls_version" {
  value       = azurerm_servicebus_namespace.this.minimum_tls_version
  description = "The minimum TLS version for the namespace."
}

output "name" {
  value       = azurerm_servicebus_namespace.this.name
  description = "The name of the Service Bus namespace."
}

output "premium_messaging_partitions" {
  value       = azurerm_servicebus_namespace.this.premium_messaging_partitions
  description = "Number of premium messaging partitions if applicable."
}

output "public_network_access_enabled" {
  value       = azurerm_servicebus_namespace.this.public_network_access_enabled
  description = "Whether public network access is enabled for the namespace."
}

output "resource_group_name" {
  value       = azurerm_servicebus_namespace.this.resource_group_name
  description = "The name of the resource group the namespace belongs to."
}

output "sku" {
  value       = azurerm_servicebus_namespace.this.sku
  description = "The SKU of the Service Bus namespace."
}
