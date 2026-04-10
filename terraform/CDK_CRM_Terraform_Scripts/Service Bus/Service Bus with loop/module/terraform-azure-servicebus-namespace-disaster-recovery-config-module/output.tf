#outputs.tf
# Outputs key attributes of the Service Bus Namespace Disaster Recovery configuration, including alias details, keys, and linked namespaces.

output "namespace_dr_config" {
  description = "Full object of the Service Bus Namespace Disaster Recovery Config."
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this
}

output "alias_authorization_rule_id" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.alias_authorization_rule_id
  description = "The ID of the alias authorization rule."
}

output "default_primary_key" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.default_primary_key
  description = "The default primary key for the disaster recovery config."
}

output "default_secondary_key" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.default_secondary_key
  description = "The default secondary key for the disaster recovery config."
}

output "id" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.id
  description = "The ID of the ServiceBus namespace disaster recovery configuration."
}

output "name" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.name
  description = "The name of the disaster recovery configuration alias."
}

output "partner_namespace_id" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.partner_namespace_id
  description = "The ID of the partner namespace."
}

output "primary_connection_string_alias" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.primary_connection_string_alias
  description = "The alias of the primary connection string."
}

output "primary_namespace_id" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.primary_namespace_id
  description = "The ID of the primary ServiceBus namespace."
}

output "secondary_connection_string_alias" {
  value       = azurerm_servicebus_namespace_disaster_recovery_config.this.secondary_connection_string_alias
  description = "The alias of the secondary connection string."
}
