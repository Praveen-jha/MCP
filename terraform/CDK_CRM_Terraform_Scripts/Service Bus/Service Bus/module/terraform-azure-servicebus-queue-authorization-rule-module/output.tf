#outputs.tf
# Outputs details and connection information for the Azure Service Bus Queue Authorization Rule.

output "authorization_rule_resource" {
  description = "Full resource object of the authorization rule."
  value       = azurerm_servicebus_queue_authorization_rule.this
}

output "id" {
  value       = azurerm_servicebus_queue_authorization_rule.this.id
  description = "The ID of the ServiceBus Queue Authorization Rule."
}

output "listen" {
  value       = azurerm_servicebus_queue_authorization_rule.this.listen
  description = "Whether the listen permission is enabled for this rule."
}

output "manage" {
  value       = azurerm_servicebus_queue_authorization_rule.this.manage
  description = "Whether the manage permission is enabled for this rule."
}

output "name" {
  value       = azurerm_servicebus_queue_authorization_rule.this.name
  description = "The name of the ServiceBus Queue Authorization Rule."
}

output "primary_connection_string" {
  value       = azurerm_servicebus_queue_authorization_rule.this.primary_connection_string
  description = "The primary connection string for the authorization rule."
}

output "primary_connection_string_alias" {
  value       = azurerm_servicebus_queue_authorization_rule.this.primary_connection_string_alias
  description = "The alias for the primary connection string."
}

output "primary_key" {
  value       = azurerm_servicebus_queue_authorization_rule.this.primary_key
  description = "The primary key for the authorization rule."
}

output "queue_id" {
  value       = azurerm_servicebus_queue_authorization_rule.this.queue_id
  description = "The ID of the ServiceBus Queue to which this authorization rule belongs."
}

output "secondary_connection_string" {
  value       = azurerm_servicebus_queue_authorization_rule.this.secondary_connection_string
  description = "The secondary connection string for the authorization rule."
}

output "secondary_connection_string_alias" {
  value       = azurerm_servicebus_queue_authorization_rule.this.secondary_connection_string_alias
  description = "The alias for the secondary connection string."
}

output "secondary_key" {
  value       = azurerm_servicebus_queue_authorization_rule.this.secondary_key
  description = "The secondary key for the authorization rule."
}

output "send" {
  value       = azurerm_servicebus_queue_authorization_rule.this.send
  description = "Whether the send permission is enabled for this rule."
}
