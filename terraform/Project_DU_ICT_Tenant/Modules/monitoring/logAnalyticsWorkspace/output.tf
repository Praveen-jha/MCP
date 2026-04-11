output "log_analytics_workspace" {
  description = "The ID of the Log Analytics workspace created in Azure."
  value       = azurerm_log_analytics_workspace.log.id
}