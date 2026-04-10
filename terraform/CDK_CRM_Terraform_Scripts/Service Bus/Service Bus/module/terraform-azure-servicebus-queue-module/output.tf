#outputs.tf
# Exposes key attributes of the created Azure Service Bus Queue for downstream use or reference.

output "servicebus_queue" {
  description = "The Config object of the Service Bus Queue"
  value       = azurerm_servicebus_queue.this
}

output "id" {
  description = "The ID of the Service Bus Queue."
  value       = azurerm_servicebus_queue.this.id
}

output "name" {
  description = "The name of the Service Bus Queue."
  value       = azurerm_servicebus_queue.this.name
}

output "namespace_id" {
  description = "The namespace ID of the Service Bus Queue."
  value       = azurerm_servicebus_queue.this.namespace_id
}

output "status" {
  description = "The status of the Service Bus Queue."
  value       = azurerm_servicebus_queue.this.status
}

output "lock_duration" {
  description = "The lock duration of the queue messages."
  value       = azurerm_servicebus_queue.this.lock_duration
}

output "max_message_size_in_kilobytes" {
  description = "Maximum size of a message in KB."
  value       = azurerm_servicebus_queue.this.max_message_size_in_kilobytes
}

output "max_size_in_megabytes" {
  description = "Maximum size of the queue in MB."
  value       = azurerm_servicebus_queue.this.max_size_in_megabytes
}

output "requires_duplicate_detection" {
  description = "Whether duplicate detection is required."
  value       = azurerm_servicebus_queue.this.requires_duplicate_detection
}

output "requires_session" {
  description = "Whether session support is enabled."
  value       = azurerm_servicebus_queue.this.requires_session
}

output "default_message_ttl" {
  description = "Default TTL for messages in the queue."
  value       = azurerm_servicebus_queue.this.default_message_ttl
}

output "dead_lettering_on_message_expiration" {
  description = "Dead lettering on message expiration."
  value       = azurerm_servicebus_queue.this.dead_lettering_on_message_expiration
}

output "duplicate_detection_history_time_window" {
  description = "Time window for duplicate detection."
  value       = azurerm_servicebus_queue.this.duplicate_detection_history_time_window
}

output "max_delivery_count" {
  description = "Maximum delivery count before moving to dead letter."
  value       = azurerm_servicebus_queue.this.max_delivery_count
}

output "auto_delete_on_idle" {
  description = "Auto-delete on idle time."
  value       = azurerm_servicebus_queue.this.auto_delete_on_idle
}

output "express_enabled" {
  description = "Whether Express is enabled."
  value       = azurerm_servicebus_queue.this.express_enabled
}

output "partitioning_enabled" {
  description = "Whether the queue is partitioned."
  value       = azurerm_servicebus_queue.this.partitioning_enabled
}

output "batched_operations_enabled" {
  description = "Whether batched operations are enabled."
  value       = azurerm_servicebus_queue.this.batched_operations_enabled
}

output "forward_to" {
  description = "Queue or Topic name to forward messages to."
  value       = azurerm_servicebus_queue.this.forward_to
}

output "forward_dead_lettered_messages_to" {
  description = "Queue or Topic name to forward dead lettered messages to."
  value       = azurerm_servicebus_queue.this.forward_dead_lettered_messages_to
}
