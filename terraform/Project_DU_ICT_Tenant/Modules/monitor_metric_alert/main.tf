resource "azurerm_monitor_metric_alert" "alert" {
  name                = var.metric_alert_name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.description

  dynamic "criteria" {
    for_each = var.criteria_config
    content {
      metric_namespace       = criteria.value.metric_namespace
      metric_name            = criteria.value.metric_name
      aggregation            = criteria.value.aggregation
      operator               = criteria.value.operator
      threshold              = criteria.value.threshold
      skip_metric_validation = criteria.value.skip_metric_validation
    }
  }

  severity = "1"

  action {
    action_group_id = var.action_group_id
  }
}
