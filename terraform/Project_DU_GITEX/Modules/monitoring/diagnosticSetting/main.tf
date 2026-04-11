# Creates a diagnostic setting for monitoring Azure resources.
resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  
  dynamic "enabled_log" {
    for_each = var.enabled_log.category
    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_log" {
    for_each = var.enabled_log.category_groups
    content {
      category_group = enabled_log.value
    }
  }

  # The dynamic block iterates over the elements of the "metric" variable, which is a list of metric categories. It allows for dynamic configuration of each metric category based on the provided input.
  dynamic "metric" {
    for_each = toset(var.metric)
    content {
      category = metric.value
    }
  }

}
