nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "existing"
  businessunit    = "ea"
  identity        = "eid"
}

hub_resource_group_name            = "EID-EA-RG-HUB01"
non_prod_resource_group_name       = "EID-EA-RG-NPD01"
prod_resource_group_name           = "EID-EA-RG-PRD01"
hub_sha_virtual_machine_name       = "EID-EA-VMSHA-HUB01"
non_prod_shir_virtual_machine_name = "EID-EA-VMSHIR-NPD01"
non_prod_odgw_virtual_machine_name = "EID-EA-VMODGW-NPD01"
prod_shir_virtual_machine_name     = "EID-EA-VMSHIR-PRD01"
prod_odgw_virtual_machine_name     = "EID-EA-VMODGW-PRD01"
virtual_network_gateway_name       = "EID-EA-VNG-HUB01"
non_prod_data_factory_name         = "EID-EA-ADF-NPD01"
prod_data_factory_name             = "EID-EA-ADF-PRD01"


action_group_details = {
  short_name = "EID-ACTION-GROUP"
  email_details = {
    "Ekta Jarwal" = ""
  }
}

vm_alerts_details = {
  alert_severity    = 2
  alert_frequency   = "PT5M" # Every 5 minutes
  alert_description = "Monitoring Virtual Machine performance metrics."
  alert_window_size = "PT15M" # Over a 15-minute window
  alert_enabled     = true
}

vm_metric_criteria = {
  "Percentage CPU" = {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    aggregation      = "Average"
    threshold        = 10
    operator         = "GreaterThan"
  } 
}

vpn_alerts_details = {
  alert_severity    = 2
  alert_frequency   = "PT5M"
  alert_description = "Monitoring VPN Gateway connectivity."
  alert_window_size = "PT15M"
  alert_enabled     = true
}

vpn_metric_criteria = {
  "AverageBandwidth" = {
    metric_namespace = "Microsoft.Network/virtualNetworkGateways"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0
  }
}

data_factory_alerts_details = {
  alert_severity    = 2
  alert_frequency   = "PT5M"
  alert_description = "Monitoring Data Factory pipeline runs."
  alert_window_size = "PT15M"
  alert_enabled     = true
}

data_factory_metric_criteria = {
  "PipelineFailedRuns" = {
    metric_namespace = "Microsoft.DataFactory/factories"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0
  }
}

budget_amount     = 5000.00
budget_time_grain = "Monthly"
budget_start_date = "2025-07-01T00:00:00Z"
budget_end_date   = "2026-07-01T00:00:00Z"

budget_notifications = [
  {
    enabled        = true
    threshold      = 80.0
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = [""]
    contact_roles  = ["Owner"]
  }
]
