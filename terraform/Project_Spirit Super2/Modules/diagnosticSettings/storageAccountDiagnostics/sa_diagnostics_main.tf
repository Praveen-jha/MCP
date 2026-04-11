resource "azurerm_monitor_diagnostic_setting" "dignsotic_setting" {
  name                       = var.dignosticSettingName
  target_resource_id         = var.targetResourceId
  log_analytics_workspace_id = var.logAnalyticsWorkspaceId

  metric {
    category = "Transaction"
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings_blob" {
  name                       = var.dignosticSettingName
  target_resource_id         = "${var.targetResourceId}/blobServices/default"
  log_analytics_workspace_id = var.logAnalyticsWorkspaceId
  enabled_log {
    category_group = "allLogs"
  }
  enabled_log {
    category_group = "Audit"
  }

  metric {
    category = "Transaction"
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings_file" {
  name                       = var.dignosticSettingName
  target_resource_id         = "${var.targetResourceId}/fileServices/default"
  log_analytics_workspace_id = var.logAnalyticsWorkspaceId
  enabled_log {
    category_group = "allLogs"
  }
  enabled_log {
    category_group = "Audit"
  }

  metric {
    category = "Transaction"
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings_table" {
  name                       = var.dignosticSettingName
  target_resource_id         = "${var.targetResourceId}/tableServices/default"
  log_analytics_workspace_id = var.logAnalyticsWorkspaceId
  enabled_log {
    category_group = "allLogs"
  }
  enabled_log {
    category_group = "Audit"
  }

  metric {
    category = "Transaction"
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings_queue" {
  name                       = var.dignosticSettingName
  target_resource_id         = "${var.targetResourceId}/queueServices/default"
  log_analytics_workspace_id = var.logAnalyticsWorkspaceId
  enabled_log {
    category_group = "allLogs"
  }
  enabled_log {
    category_group = "Audit"
  }

  metric {
    category = "Transaction"
  }
}
