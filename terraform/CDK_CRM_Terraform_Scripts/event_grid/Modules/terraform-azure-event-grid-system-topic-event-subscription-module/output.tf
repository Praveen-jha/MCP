output "id" {
  description = "The ID of the EventGrid System Topic Event Subscription"
  value       = azurerm_eventgrid_system_topic_event_subscription.this.id
}

output "name" {
  description = "The name of the EventGrid System Topic Event Subscription"
  value       = azurerm_eventgrid_system_topic_event_subscription.this.name
}

output "system_topic" {
  description = "The System Topic name"
  value       = azurerm_eventgrid_system_topic_event_subscription.this.system_topic
}

output "resource_group_name" {
  description = "The resource group name"
  value       = azurerm_eventgrid_system_topic_event_subscription.this.resource_group_name
}

output "event_delivery_schema" {
  description = "The event delivery schema"
  value       = azurerm_eventgrid_system_topic_event_subscription.this.event_delivery_schema
}

output "included_event_types" {
  description = "The included event types"
  value       = azurerm_eventgrid_system_topic_event_subscription.this.included_event_types
}

output "labels" {
  description = "The labels assigned to the event subscription"
  value       = azurerm_eventgrid_system_topic_event_subscription.this.labels
}
