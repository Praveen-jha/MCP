nameConfig = {
  defaultLocation              = "australia east"
  existingdataGovernanceRGName = "ngdp1t-governance-rg"
  existingApplicationRGName    = "ngdp1t-application-rg"
  existingVnetName             = "platform1-aue-vnet1"
  deploymentEnvironment        = "t"
  identity                     = "ngdp"
  identity2                    = "platform"
  index                        = 1
  publicNetworkAccessEnabled   = false
  purviewResourceID            = "/subscriptions/2aa0f3d8-42c4-41fa-b03e-c19b09f6ce8c/resourceGroups/ngdp1t-governance-rg/providers/Microsoft.Purview/accounts/ngdp1t-pview"
  tags = {
    business_owner = "Technology"
    managed_by     = "terraform"
    source         = ""
  }
}

email_receiver = {
  "email_receiver1" = {
    name          = "Arron"
    email_address = "arron.pitman@spiritsuper.com.au"
  }
  "email_receiver2" = {
    name          = "Endarjit"
    email_address = "endarjit.singh@spiritsuper.com.au"
  }
}

key_vault_alert = {
  description      = "Action will be triggered whenever the average Overall Vault Availability is less than threshold value."
  metric_name      = "Availability"
  metric_namespace = "Microsoft.KeyVault/vaults"
  threshold        = 95
  aggregation      = "Average"
  operator         = "LessThan"
  frequency        = "PT1M"
  window_size      = "PT5M"
}

storage_account_one_alert1 = {
  description      = "Action will be triggered Whenever the average Availability is less than threshold value."
  metric_name      = "Availability"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 95
  aggregation      = "Average"
  operator         = "LessThan"
  frequency        = "PT1M"
  window_size      = "PT5M"
}

storage_account_one_alert2 = {
  description      = "Action will be triggered Whenever the average UsedCapacity is greater than threshold value."
  metric_name      = "UsedCapacity"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 20971520
  aggregation      = "Average"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_one_alert3 = {
  description      = "Action will be triggered Whenever the average Ingress is greater than threshold value."
  metric_name      = "Ingress"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 20971520
  aggregation      = "Average"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_one_alert4 = {
  description      = "Action will be triggered Whenever the average Egress is greater than threshold value."
  metric_name      = "Egress"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 20971520
  aggregation      = "Average"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_two_alert1 = {
  description      = "Action will be triggered Whenever the average Availability is less than threshold value."
  metric_name      = "Availability"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 95
  aggregation      = "Average"
  operator         = "LessThan"
  frequency        = "PT1M"
  window_size      = "PT5M"
}

storage_account_two_alert2 = {
  description      = "Action will be triggered Whenever the average UsedCapacity is greater than threshold value."
  metric_name      = "UsedCapacity"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 20971520
  aggregation      = "Average"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_two_alert3 = {
  description      = "Action will be triggered Whenever the average Ingress is greater than threshold value."
  metric_name      = "Ingress"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 20971520
  aggregation      = "Average"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_two_alert4 = {
  description      = "Action will be triggered Whenever the average Egress is greater than threshold value."
  metric_name      = "Egress"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  threshold        = 20971520
  aggregation      = "Average"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_workspace_alert1 = {
  description      = "Action will be triggered Whenever the total IntegrationActivityRunsEnded is greater than threshold value."
  metric_name      = "IntegrationActivityRunsEnded"
  metric_namespace = "Microsoft.Synapse/workspaces"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_workspace_alert2 = {
  description      = "Action will be triggered Whenever the total IntegrationTriggerRunsEnded is greater than threshold value."
  metric_name      = "IntegrationTriggerRunsEnded"
  metric_namespace = "Microsoft.Synapse/workspaces"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_workspace_alert3 = {
  description      = "Action will be triggered Whenever the total IntegrationPipelineRunsEnded is greater than threshold value."
  metric_name      = "IntegrationPipelineRunsEnded"
  metric_namespace = "Microsoft.Synapse/workspaces"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

logic_app_alert1 = {
  description      = "Action will be triggered Whenever the total Triggers Failed is greater than threshold value."
  metric_name      = "TriggersFailed"
  metric_namespace = "Microsoft.Logic/workflows"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

logic_app_alert2 = {
  description      = "Action will be triggered Whenever the total TriggersSucceeded is greater than threshold value."
  metric_name      = "TriggersSucceeded"
  metric_namespace = "Microsoft.Logic/workflows"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

logic_app_alert3 = {
  description      = "Action will be triggered Whenever the total RunsCompleted is greater than threshold value."
  metric_name      = "RunsCompleted"
  metric_namespace = "Microsoft.Logic/workflows"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

logic_app_alert4 = {
  description      = "Action will be triggered Whenever the total RunsFailed is greater than threshold value."
  metric_name      = "RunsFailed"
  metric_namespace = "Microsoft.Logic/workflows"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

logic_app_alert5 = {
  description      = "Action will be triggered Whenever the total RunsSucceeded is greater than threshold value."
  metric_name      = "RunsSucceeded"
  metric_namespace = "Microsoft.Logic/workflows"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

logic_app_alert6 = {
  description      = "Action will be triggered Whenever the total ActionCompleted is greater than threshold value."
  metric_name      = "ActionsCompleted"
  metric_namespace = "Microsoft.Logic/workflows"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

logic_app_alert7 = {
  description      = "Action will be triggered Whenever the total ActionFailed is greater than threshold value."
  metric_name      = "ActionsFailed"
  metric_namespace = "Microsoft.Logic/workflows"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_alert1 = {
  description      = "Action will be triggered Whenever the total ScanFailed is greater than threshold value."
  metric_name      = "ScanFailed"
  metric_namespace = "Microsoft.Purview/accounts"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_alert2 = {
  description      = "Action will be triggered Whenever the total ScanCompleted is greater than threshold value."
  metric_name      = "ScanCompleted"
  metric_namespace = "Microsoft.Purview/accounts"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_alert3 = {
  description      = "Action will be triggered Whenever the total ScanCancelled is greater than threshold value."
  metric_name      = "ScanCancelled"
  metric_namespace = "Microsoft.Purview/accounts"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_alert4 = {
  description      = "Action will be triggered Whenever the total ScanTimeTaken is greater than threshold value."
  metric_name      = "ScanTimeTaken"
  metric_namespace = "Microsoft.Purview/accounts"
  threshold        = 0
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

kv_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

kv_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_one_blob_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_one_blob_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_one_dfs_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_one_dfs_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_two_blob_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_two_blob_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_two_dfs_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

storage_account_two_dfs_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

databricks_brows_auth_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

databricks_brows_auth_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

databricks_ui_api_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

databricks_ui_api_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_sql_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_sql_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_sql_on_demand_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_sql_on_demand_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_dev_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

synapse_dev_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_ingestion_blob_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_ingestion_blob_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_ingestion_queue_pe_alert1 = {
  description      = "Action will be triggered Whenever the total PEBytesIn is greater than threshold value."
  metric_name      = "PEBytesIn"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}

purview_ingestion_queue_pe_alert2 = {
  description      = "Action will be triggered Whenever the total PEBytesOut is greater than threshold value."
  metric_name      = "PEBytesOut"
  metric_namespace = "Microsoft.Network/privateEndpoints"
  threshold        = 8000
  aggregation      = "Total"
  operator         = "GreaterThan"
  frequency        = "PT1M"
  window_size      = "PT1H"
}
