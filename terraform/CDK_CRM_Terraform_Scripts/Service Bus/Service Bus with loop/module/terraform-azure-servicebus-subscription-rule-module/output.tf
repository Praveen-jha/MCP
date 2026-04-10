#Outputs.tf
# Outputs attributes of the Azure Service Bus Subscription Rule, including filter details, rule name, and subscription ID.

output "subscription_rule" {
  value       = azurerm_servicebus_subscription_rule.this
  description = "Full resource block of the created ServiceBus Subscription Rule"
}

output "action" {
  value       = azurerm_servicebus_subscription_rule.this.action
  description = "SQL-like action expression performed against a BrokeredMessage."
}

output "filter_type" {
  value       = azurerm_servicebus_subscription_rule.this.filter_type
  description = "The type of filter applied (SqlFilter or CorrelationFilter)."
}

output "id" {
  value       = azurerm_servicebus_subscription_rule.this.id
  description = "ID of the ServiceBus Subscription Rule."
}

output "name" {
  value       = azurerm_servicebus_subscription_rule.this.name
  description = "Name of the Subscription Rule."
}

output "sql_filter" {
  value       = azurerm_servicebus_subscription_rule.this.sql_filter
  description = "The SQL filter expression used in the rule, if applicable."
}

output "sql_filter_compatibility_level" {
  value       = azurerm_servicebus_subscription_rule.this.sql_filter_compatibility_level
  description = "The compatibility level of the SQL filter."
}

output "subscription_id" {
  value       = azurerm_servicebus_subscription_rule.this.subscription_id
  description = "The ID of the ServiceBus Subscription this rule belongs to."
}
