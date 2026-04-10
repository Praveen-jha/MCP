#outputs.tf
# Output values for the Azure Service Bus Namespace Authorization Rule resource.

output "namespace_authorization_rule" {
  description = "Full resource object for further use."
  value       = azurerm_servicebus_namespace_authorization_rule.this
}

output "id" {
  description = "The ID of the Service Bus Namespace Authorization Rule."
  value       = azurerm_servicebus_namespace_authorization_rule.this.id
}

output "listen" {
  description = "Indicates whether the Authorization Rule has listen access enabled."
  value       = azurerm_servicebus_namespace_authorization_rule.this.listen
}

output "manage" {
  description = "Indicates whether the Authorization Rule has manage access enabled. Requires both listen and send permissions to be true."
  value       = azurerm_servicebus_namespace_authorization_rule.this.manage
}

output "name" {
  description = "The name of the Service Bus Namespace Authorization Rule."
  value       = azurerm_servicebus_namespace_authorization_rule.this.name
}

output "namespace_id" {
  description = "The ID of the associated Service Bus Namespace."
  value       = azurerm_servicebus_namespace_authorization_rule.this.namespace_id
}

output "primary_connection_string" {
  description = "The primary connection string for accessing the Service Bus Namespace with this Authorization Rule."
  value       = azurerm_servicebus_namespace_authorization_rule.this.primary_connection_string
}

output "primary_connection_string_alias" {
  description = "The alias of the primary connection string, used if the namespace is geo-paired."
  value       = azurerm_servicebus_namespace_authorization_rule.this.primary_connection_string_alias
}

output "primary_key" {
  description = "The primary key associated with the Authorization Rule."
  value       = azurerm_servicebus_namespace_authorization_rule.this.primary_key
}

output "secondary_connection_string" {
  description = "The secondary connection string for accessing the Service Bus Namespace with this Authorization Rule."
  value       = azurerm_servicebus_namespace_authorization_rule.this.secondary_connection_string
}

output "secondary_connection_string_alias" {
  description = "The alias of the secondary connection string, used if the namespace is geo-paired."
  value       = azurerm_servicebus_namespace_authorization_rule.this.secondary_connection_string_alias
}

output "secondary_key" {
  description = "The secondary key associated with the Authorization Rule."
  value       = azurerm_servicebus_namespace_authorization_rule.this.secondary_key
}

output "send" {
  description = "Indicates whether the Authorization Rule has send access enabled."
  value       = azurerm_servicebus_namespace_authorization_rule.this.send
}
