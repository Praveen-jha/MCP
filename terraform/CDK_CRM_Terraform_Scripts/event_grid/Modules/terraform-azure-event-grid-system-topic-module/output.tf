output "id" {
  description = "The ID of the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.id
}

output "name" {
  description = "The name of the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.name
}

output "resource_group_name" {
  description = "The resource group name where the EventGrid System Topic is created"
  value       = azurerm_eventgrid_system_topic.this.resource_group_name
}

output "location" {
  description = "The location of the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.location
}

output "source_arm_resource_id" {
  description = "The source ARM resource ID of the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.source_arm_resource_id
}

output "topic_type" {
  description = "The topic type of the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.topic_type
}

output "identity" {
  description = "The identity configuration of the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.identity
}

output "metric_arm_resource_id" {
  description = "The metric ARM resource ID of the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.metric_arm_resource_id
}

output "tags" {
  description = "The tags assigned to the EventGrid System Topic"
  value       = azurerm_eventgrid_system_topic.this.tags
}
