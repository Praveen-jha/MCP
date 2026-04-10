#Outputs for Monitor Metric Alert module main file
output "alert_id" {
  description = "The ID of the created metric alert."
  value       ={ for k, v in  azurerm_monitor_metric_alert.metric_alerts :  k => v.id}
}

output "alert_name" {
  description = "The name of the created metric alert."
  value       = { for k, v in  azurerm_monitor_metric_alert.metric_alerts :  k => v.name}
}
