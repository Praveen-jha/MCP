resource "azurerm_monitor_diagnostic_setting" "dignsotic_setting" {
  name                       = var.dignosticSettingName
  target_resource_id         = var.targetResourceId
  log_analytics_workspace_id = var.logAnalyticsWorkspaceId

  enabled_log {
    category_group = "allLogs"
  }
}
