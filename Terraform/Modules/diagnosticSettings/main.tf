resource "azurerm_monitor_diagnostic_setting" "dignsoticSetting" {
  name                       = var.dignosticSettingName
  target_resource_id         = var.targetResourceId
  log_analytics_workspace_id = var.logAnalyticsWorkspaceId
  dynamic "enabled_log" {
    for_each = var.enabledLogs
    content {
      category_group = enabled_log.value
    }
  }
  dynamic "metric" {
    for_each = var.metric
    content {
      category = metric.value
    }
  }
  lifecycle {
    ignore_changes = [
      # metric
    ]
  }
}