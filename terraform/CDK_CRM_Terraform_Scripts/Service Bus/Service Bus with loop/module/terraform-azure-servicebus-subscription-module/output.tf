#Outputs.tf
# Outputs various attributes of the created Azure ServiceBus Subscription, including configuration details, forwarding settings, and operational status.

output "servicebus_subscription" {
  description = "Full resource block of the created ServiceBus Subscription."
  value       = azurerm_servicebus_subscription.this
}

output "auto_delete_on_idle" {
  value       = azurerm_servicebus_subscription.this.auto_delete_on_idle
  description = "Time span idle after which the subscription is automatically deleted."
}

output "batched_operations_enabled" {
  value       = azurerm_servicebus_subscription.this.batched_operations_enabled
  description = "Whether batched operations are enabled on this subscription."
}

output "client_scoped_subscription_enabled" {
  value       = azurerm_servicebus_subscription.this.client_scoped_subscription_enabled
  description = "Whether the subscription has client-scoped access."
}

output "dead_lettering_on_filter_evaluation_error" {
  value       = azurerm_servicebus_subscription.this.dead_lettering_on_filter_evaluation_error
  description = "Whether messages that can't be evaluated against the filter will be dead-lettered."
}

output "dead_lettering_on_message_expiration" {
  value       = azurerm_servicebus_subscription.this.dead_lettering_on_message_expiration
  description = "Whether expired messages should be dead-lettered."
}

output "default_message_ttl" {
  value       = azurerm_servicebus_subscription.this.default_message_ttl
  description = "Default message time-to-live for messages in the subscription."
}

output "forward_dead_lettered_messages_to" {
  value       = azurerm_servicebus_subscription.this.forward_dead_lettered_messages_to
  description = "Forward dead-lettered messages to another queue or topic."
}

output "forward_to" {
  value       = azurerm_servicebus_subscription.this.forward_to
  description = "Forward messages to another queue or topic."
}

output "id" {
  value       = azurerm_servicebus_subscription.this.id
  description = "The ID of the ServiceBus Subscription."
}

output "lock_duration" {
  value       = azurerm_servicebus_subscription.this.lock_duration
  description = "The duration of a peek-lock."
}

output "max_delivery_count" {
  value       = azurerm_servicebus_subscription.this.max_delivery_count
  description = "Maximum delivery count before messages are dead-lettered."
}

output "name" {
  value       = azurerm_servicebus_subscription.this.name
  description = "The name of the ServiceBus Subscription."
}

output "requires_session" {
  value       = azurerm_servicebus_subscription.this.requires_session
  description = "Whether the subscription requires sessions."
}

output "status" {
  value       = azurerm_servicebus_subscription.this.status
  description = "The status of the subscription (e.g., Active, Disabled)."
}

output "topic_id" {
  value       = azurerm_servicebus_subscription.this.topic_id
  description = "The ID of the topic this subscription belongs to."
}
