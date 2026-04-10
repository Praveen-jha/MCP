output "logWorkspaceNameName" {
  description = "The name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.name
}

output "logWorkspaceId" {
  description = "The ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.id
}