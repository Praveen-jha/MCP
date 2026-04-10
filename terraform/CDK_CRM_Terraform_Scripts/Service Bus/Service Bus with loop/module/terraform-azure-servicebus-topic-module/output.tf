#output.tf
## Outputs to expose various attributes of the created Azure Service Bus Topic, including its ID, status, configuration settings, and capabilities like duplicate detection and message ordering.


output "topic" {
  value       = azurerm_servicebus_topic.this
  description = "Full azurerm_servicebus_topic resource."
}

output "auto_delete_on_idle" {
  value       = azurerm_servicebus_topic.this.auto_delete_on_idle
  description = "The idle interval after which the topic is automatically deleted."
}

output "batched_operations_enabled" {
  value       = azurerm_servicebus_topic.this.batched_operations_enabled
  description = "Indicates whether batched operations are enabled on the topic."
}

output "default_message_ttl" {
  value       = azurerm_servicebus_topic.this.default_message_ttl
  description = "The default time to live for messages sent to this topic."
}

output "duplicate_detection_history_time_window" {
  value       = azurerm_servicebus_topic.this.duplicate_detection_history_time_window
  description = "The duration for which duplicate messages are detected."
}

output "express_enabled" {
  value       = azurerm_servicebus_topic.this.express_enabled
  description = "Indicates whether Express Entities are enabled for this topic."
}

output "id" {
  value       = azurerm_servicebus_topic.this.id
  description = "The ID of the ServiceBus Topic."
}

output "max_message_size_in_kilobytes" {
  value       = azurerm_servicebus_topic.this.max_message_size_in_kilobytes
  description = "The maximum size of a message allowed on the topic in kilobytes."
}

output "max_size_in_megabytes" {
  value       = azurerm_servicebus_topic.this.max_size_in_megabytes
  description = "The maximum size of the topic in megabytes."
}

output "name" {
  value       = azurerm_servicebus_topic.this.name
  description = "The name of the ServiceBus Topic."
}

output "namespace_id" {
  value       = azurerm_servicebus_topic.this.namespace_id
  description = "The ID of the ServiceBus Namespace in which the topic is created."
}

output "partitioning_enabled" {
  value       = azurerm_servicebus_topic.this.partitioning_enabled
  description = "Indicates whether partitioning is enabled for the topic."
}

output "requires_duplicate_detection" {
  value       = azurerm_servicebus_topic.this.requires_duplicate_detection
  description = "Indicates whether the topic requires duplicate detection."
}

output "status" {
  value       = azurerm_servicebus_topic.this.status
  description = "The current status of the topic (Active or Disabled)."
}

output "support_ordering" {
  value       = azurerm_servicebus_topic.this.support_ordering
  description = "Indicates whether the topic supports message ordering."
}
