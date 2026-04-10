resource "azurerm_monitor_autoscale_setting" "auto_scale" {
  name                = var.autoscale_setting_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.target_resource_id

  profile {
    name = "defaultProfile"

    capacity {
      minimum = var.autoscale_min_capacity
      maximum = var.autoscale_max_capacity
      default = var.autoscale_default_capacity
    }

    rule {
      metric_trigger {
        metric_name        = var.cpu_metric_name
        metric_resource_id = var.target_resource_id
        operator           = var.operator_increase
        statistic          = var.statistic
        threshold          = var.cpu_metric_threshold_increase
        time_aggregation   = var.time_aggregation
        time_grain         = var.time_grain
        time_window        = var.time_window
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = tostring(var.increase_scale_action_change_count)
        cooldown  = var.scale_action_cooldown
      }
    }

    rule {
      metric_trigger {
        metric_name        = var.cpu_metric_name
        metric_resource_id = var.target_resource_id
        operator           = var.operator_decrease
        statistic          = var.statistic
        threshold          = var.cpu_metric_threshold_decrease
        time_aggregation   = var.time_aggregation
        time_grain         = var.time_grain
        time_window        = var.time_window
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = tostring(var.decrease_scale_action_change_count)
        cooldown  = var.scale_action_cooldown
      }
    }
  }
}
