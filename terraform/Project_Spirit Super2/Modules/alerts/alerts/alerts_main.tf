resource "azurerm_monitor_metric_alert" "key_vault_alert" {
  name                = var.alert_name
  scopes              = [var.scope]
  resource_group_name = var.resource_group_name
  description         = var.description

  criteria {
    metric_name      = var.metric_name
    metric_namespace = var.metric_namespace
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.threshold
  }

  action {
    action_group_id = var.action_group_id
  }

  frequency   = var.frequency
  window_size = var.window_size

}
