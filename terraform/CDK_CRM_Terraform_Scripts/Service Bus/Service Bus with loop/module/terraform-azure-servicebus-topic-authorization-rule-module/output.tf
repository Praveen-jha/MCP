#Outputs.tf
# Exposes output values for the Azure Service Bus Topic Authorization Rule resource and its properties.

output "topic_authorization_rule" {
  value       = azurerm_servicebus_topic_authorization_rule.this
  description = "Full resource of the ServiceBus Topic Authorization Rule"
}

output "id" {
  value       = azurerm_servicebus_topic_authorization_rule.this.id
  description = "The ID of the ServiceBus Topic Authorization Rule."
}

output "listen" {
  value       = azurerm_servicebus_topic_authorization_rule.this.listen
  description = "Indicates whether listen access is granted."
}

output "manage" {
  value       = azurerm_servicebus_topic_authorization_rule.this.manage
  description = "Indicates whether manage access is granted."
}

output "name" {
  value       = azurerm_servicebus_topic_authorization_rule.this.name
  description = "The name of the Authorization Rule."
}

output "primary_connection_string" {
  value       = azurerm_servicebus_topic_authorization_rule.this.primary_connection_string
  description = "The primary connection string for the Authorization Rule."
}

output "primary_connection_string_alias" {
  value       = azurerm_servicebus_topic_authorization_rule.this.primary_connection_string_alias
  description = "The alias for the primary connection string, used in Geo DR scenarios."
}

output "primary_key" {
  value       = azurerm_servicebus_topic_authorization_rule.this.primary_key
  description = "The primary key for the Authorization Rule."
}

output "secondary_connection_string" {
  value       = azurerm_servicebus_topic_authorization_rule.this.secondary_connection_string
  description = "The secondary connection string for the Authorization Rule."
}

output "secondary_connection_string_alias" {
  value       = azurerm_servicebus_topic_authorization_rule.this.secondary_connection_string_alias
  description = "The alias for the secondary connection string, used in Geo DR scenarios."
}

output "secondary_key" {
  value       = azurerm_servicebus_topic_authorization_rule.this.secondary_key
  description = "The secondary key for the Authorization Rule."
}

output "send" {
  value       = azurerm_servicebus_topic_authorization_rule.this.send
  description = "Indicates whether send access is granted."
}

output "topic_id" {
  value       = azurerm_servicebus_topic_authorization_rule.this.topic_id
  description = "The ID of the ServiceBus Topic to which the Authorization Rule belongs."
}
