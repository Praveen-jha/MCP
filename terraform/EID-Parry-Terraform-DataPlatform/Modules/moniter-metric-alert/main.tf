#Resource to create Monitor Metric Alert
resource "azurerm_monitor_metric_alert" "metric_alerts" {
  for_each            = var.metric_criteria
  name                = var.alert_name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes_ids
  description         = var.alert_description
  severity            = var.alert_severity
  frequency           = var.alert_frequency
  window_size         = var.alert_window_size
  enabled             = var.alert_enabled

  action {
    action_group_id = var.action_group_id
  }

  criteria {
    metric_name      = each.key
    metric_namespace = each.value.metric_namespace
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }
}
