#Outputs for Monitor Action Group module main file
output "id" {
  value       = azurerm_monitor_action_group.action_group.id
  description = "The ID of the Action Group."
}

output "name" {
  value       = azurerm_monitor_action_group.action_group.name
  description = "The Name of the Action Group."
}
