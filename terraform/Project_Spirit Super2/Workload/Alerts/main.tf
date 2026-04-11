module "action_group" {
  source                  = "../../Modules/alerts/azureActionGroup"
  action_group_name       = "${local.baseName1}-actiongroup"
  action_group_short_name = "actiongroup"
  resource_group_name     = data.azurerm_resource_group.action_group_rg.name
  email_receiver          = var.email_receiver
}

module "key_vault_alert" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_key_vault.key_vault.id
  alert_name          = "${local.baseName1}-kv01-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.key_vault_alert.description
  metric_name         = var.key_vault_alert.metric_name
  metric_namespace    = var.key_vault_alert.metric_namespace
  threshold           = var.key_vault_alert.threshold
  aggregation         = var.key_vault_alert.aggregation
  operator            = var.key_vault_alert.operator
  frequency           = var.key_vault_alert.frequency
  window_size         = var.key_vault_alert.window_size
}

module "storage_account_one_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_one.id
  alert_name          = "${local.baseName1}dls-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_alert1.description
  metric_name         = var.storage_account_one_alert1.metric_name
  metric_namespace    = var.storage_account_one_alert1.metric_namespace
  threshold           = var.storage_account_one_alert1.threshold
  aggregation         = var.storage_account_one_alert1.aggregation
  operator            = var.storage_account_one_alert1.operator
  frequency           = var.storage_account_one_alert1.frequency
  window_size         = var.storage_account_one_alert1.window_size
}

module "storage_account_one_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_one.id
  alert_name          = "${local.baseName1}dls-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_alert2.description
  metric_name         = var.storage_account_one_alert2.metric_name
  metric_namespace    = var.storage_account_one_alert2.metric_namespace
  threshold           = var.storage_account_one_alert2.threshold
  aggregation         = var.storage_account_one_alert2.aggregation
  operator            = var.storage_account_one_alert2.operator
  frequency           = var.storage_account_one_alert2.frequency
  window_size         = var.storage_account_one_alert2.window_size
}

module "storage_account_one_alert3" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_one.id
  alert_name          = "${local.baseName1}dls-alert3"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_alert3.description
  metric_name         = var.storage_account_one_alert3.metric_name
  metric_namespace    = var.storage_account_one_alert3.metric_namespace
  threshold           = var.storage_account_one_alert3.threshold
  aggregation         = var.storage_account_one_alert3.aggregation
  operator            = var.storage_account_one_alert3.operator
  frequency           = var.storage_account_one_alert3.frequency
  window_size         = var.storage_account_one_alert3.window_size
}

module "storage_account_one_alert4" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_one.id
  alert_name          = "${local.baseName1}dls-alert4"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_alert4.description
  metric_name         = var.storage_account_one_alert4.metric_name
  metric_namespace    = var.storage_account_one_alert4.metric_namespace
  threshold           = var.storage_account_one_alert4.threshold
  aggregation         = var.storage_account_one_alert4.aggregation
  operator            = var.storage_account_one_alert4.operator
  frequency           = var.storage_account_one_alert4.frequency
  window_size         = var.storage_account_one_alert4.window_size
}

module "storage_account_two_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_two.id
  alert_name          = "${local.baseName1}dls2-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_alert1.description
  metric_name         = var.storage_account_two_alert1.metric_name
  metric_namespace    = var.storage_account_two_alert1.metric_namespace
  threshold           = var.storage_account_two_alert1.threshold
  aggregation         = var.storage_account_two_alert1.aggregation
  operator            = var.storage_account_two_alert1.operator
  frequency           = var.storage_account_two_alert1.frequency
  window_size         = var.storage_account_two_alert1.window_size
}

module "storage_account_two_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_two.id
  alert_name          = "${local.baseName1}dls2-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_alert2.description
  metric_name         = var.storage_account_two_alert2.metric_name
  metric_namespace    = var.storage_account_two_alert2.metric_namespace
  threshold           = var.storage_account_two_alert2.threshold
  aggregation         = var.storage_account_two_alert2.aggregation
  operator            = var.storage_account_two_alert2.operator
  frequency           = var.storage_account_two_alert2.frequency
  window_size         = var.storage_account_two_alert2.window_size
}

module "storage_account_two_alert3" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_two.id
  alert_name          = "${local.baseName1}dls2-alert3"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_alert3.description
  metric_name         = var.storage_account_two_alert3.metric_name
  metric_namespace    = var.storage_account_two_alert3.metric_namespace
  threshold           = var.storage_account_two_alert3.threshold
  aggregation         = var.storage_account_two_alert3.aggregation
  operator            = var.storage_account_two_alert3.operator
  frequency           = var.storage_account_two_alert3.frequency
  window_size         = var.storage_account_two_alert3.window_size
}

module "storage_account_two_alert4" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_storage_account.storage_account_two.id
  alert_name          = "${local.baseName1}dls2-alert4"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_alert4.description
  metric_name         = var.storage_account_two_alert4.metric_name
  metric_namespace    = var.storage_account_two_alert4.metric_namespace
  threshold           = var.storage_account_two_alert4.threshold
  aggregation         = var.storage_account_two_alert4.aggregation
  operator            = var.storage_account_two_alert4.operator
  frequency           = var.storage_account_two_alert4.frequency
  window_size         = var.storage_account_two_alert4.window_size
}

module "synapse_workspace_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_synapse_workspace.synapse_workspace.id
  alert_name          = "${local.baseName1}-synw-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_workspace_alert1.description
  metric_name         = var.synapse_workspace_alert1.metric_name
  metric_namespace    = var.synapse_workspace_alert1.metric_namespace
  threshold           = var.synapse_workspace_alert1.threshold
  aggregation         = var.synapse_workspace_alert1.aggregation
  operator            = var.synapse_workspace_alert1.operator
  frequency           = var.synapse_workspace_alert1.frequency
  window_size         = var.synapse_workspace_alert1.window_size
}

module "synapse_workspace_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_synapse_workspace.synapse_workspace.id
  alert_name          = "${local.baseName1}-synw-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_workspace_alert2.description
  metric_name         = var.synapse_workspace_alert2.metric_name
  metric_namespace    = var.synapse_workspace_alert2.metric_namespace
  threshold           = var.synapse_workspace_alert2.threshold
  aggregation         = var.synapse_workspace_alert2.aggregation
  operator            = var.synapse_workspace_alert2.operator
  frequency           = var.synapse_workspace_alert2.frequency
  window_size         = var.synapse_workspace_alert2.window_size
}

module "synapse_workspace_alert3" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_synapse_workspace.synapse_workspace.id
  alert_name          = "${local.baseName1}-synw-alert3"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_workspace_alert3.description
  metric_name         = var.synapse_workspace_alert3.metric_name
  metric_namespace    = var.synapse_workspace_alert3.metric_namespace
  threshold           = var.synapse_workspace_alert3.threshold
  aggregation         = var.synapse_workspace_alert3.aggregation
  operator            = var.synapse_workspace_alert3.operator
  frequency           = var.synapse_workspace_alert3.frequency
  window_size         = var.synapse_workspace_alert3.window_size
}

module "logic_app_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_logic_app_workflow.logic_app.id
  alert_name          = "${local.baseName1}-logic-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.logic_app_alert1.description
  metric_name         = var.logic_app_alert1.metric_name
  metric_namespace    = var.logic_app_alert1.metric_namespace
  threshold           = var.logic_app_alert1.threshold
  aggregation         = var.logic_app_alert1.aggregation
  operator            = var.logic_app_alert1.operator
  frequency           = var.logic_app_alert1.frequency
  window_size         = var.logic_app_alert1.window_size
}

module "logic_app_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_logic_app_workflow.logic_app.id
  alert_name          = "${local.baseName1}-logic-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.logic_app_alert2.description
  metric_name         = var.logic_app_alert2.metric_name
  metric_namespace    = var.logic_app_alert2.metric_namespace
  threshold           = var.logic_app_alert2.threshold
  aggregation         = var.logic_app_alert2.aggregation
  operator            = var.logic_app_alert2.operator
  frequency           = var.logic_app_alert2.frequency
  window_size         = var.logic_app_alert2.window_size
}

module "logic_app_alert3" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_logic_app_workflow.logic_app.id
  alert_name          = "${local.baseName1}-logic-alert3"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.logic_app_alert3.description
  metric_name         = var.logic_app_alert3.metric_name
  metric_namespace    = var.logic_app_alert3.metric_namespace
  threshold           = var.logic_app_alert3.threshold
  aggregation         = var.logic_app_alert3.aggregation
  operator            = var.logic_app_alert3.operator
  frequency           = var.logic_app_alert3.frequency
  window_size         = var.logic_app_alert3.window_size
}

module "logic_app_alert4" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_logic_app_workflow.logic_app.id
  alert_name          = "${local.baseName1}-logic-alert4"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.logic_app_alert4.description
  metric_name         = var.logic_app_alert4.metric_name
  metric_namespace    = var.logic_app_alert4.metric_namespace
  threshold           = var.logic_app_alert4.threshold
  aggregation         = var.logic_app_alert4.aggregation
  operator            = var.logic_app_alert4.operator
  frequency           = var.logic_app_alert4.frequency
  window_size         = var.logic_app_alert4.window_size
}

module "logic_app_alert5" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_logic_app_workflow.logic_app.id
  alert_name          = "${local.baseName1}-logic-alert5"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.logic_app_alert5.description
  metric_name         = var.logic_app_alert5.metric_name
  metric_namespace    = var.logic_app_alert5.metric_namespace
  threshold           = var.logic_app_alert5.threshold
  aggregation         = var.logic_app_alert5.aggregation
  operator            = var.logic_app_alert5.operator
  frequency           = var.logic_app_alert5.frequency
  window_size         = var.logic_app_alert5.window_size
}

module "logic_app_alert6" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_logic_app_workflow.logic_app.id
  alert_name          = "${local.baseName1}-logic-alert6"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.logic_app_alert6.description
  metric_name         = var.logic_app_alert6.metric_name
  metric_namespace    = var.logic_app_alert6.metric_namespace
  threshold           = var.logic_app_alert6.threshold
  aggregation         = var.logic_app_alert6.aggregation
  operator            = var.logic_app_alert6.operator
  frequency           = var.logic_app_alert6.frequency
  window_size         = var.logic_app_alert6.window_size
}

module "logic_app_alert7" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_logic_app_workflow.logic_app.id
  alert_name          = "${local.baseName1}-logic-alert7"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.logic_app_alert7.description
  metric_name         = var.logic_app_alert7.metric_name
  metric_namespace    = var.logic_app_alert7.metric_namespace
  threshold           = var.logic_app_alert7.threshold
  aggregation         = var.logic_app_alert7.aggregation
  operator            = var.logic_app_alert7.operator
  frequency           = var.logic_app_alert7.frequency
  window_size         = var.logic_app_alert7.window_size
}

module "purview_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = var.nameConfig.purviewResourceID
  alert_name          = "${local.baseName1}-pview-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.purview_alert1.description
  metric_name         = var.purview_alert1.metric_name
  metric_namespace    = var.purview_alert1.metric_namespace
  threshold           = var.purview_alert1.threshold
  aggregation         = var.purview_alert1.aggregation
  operator            = var.purview_alert1.operator
  frequency           = var.purview_alert1.frequency
  window_size         = var.purview_alert1.window_size
}

module "purview_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = var.nameConfig.purviewResourceID
  alert_name          = "${local.baseName1}-pview-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.purview_alert2.description
  metric_name         = var.purview_alert2.metric_name
  metric_namespace    = var.purview_alert2.metric_namespace
  threshold           = var.purview_alert2.threshold
  aggregation         = var.purview_alert2.aggregation
  operator            = var.purview_alert2.operator
  frequency           = var.purview_alert2.frequency
  window_size         = var.purview_alert2.window_size
}

module "purview_alert3" {
  source              = "../../Modules/alerts/alerts"
  scope               = var.nameConfig.purviewResourceID
  alert_name          = "${local.baseName1}-pview-alert3"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.purview_alert3.description
  metric_name         = var.purview_alert3.metric_name
  metric_namespace    = var.purview_alert3.metric_namespace
  threshold           = var.purview_alert3.threshold
  aggregation         = var.purview_alert3.aggregation
  operator            = var.purview_alert3.operator
  frequency           = var.purview_alert3.frequency
  window_size         = var.purview_alert3.window_size
}

module "purview_alert4" {
  source              = "../../Modules/alerts/alerts"
  scope               = var.nameConfig.purviewResourceID
  alert_name          = "${local.baseName1}-pview-alert4"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.purview_alert4.description
  metric_name         = var.purview_alert4.metric_name
  metric_namespace    = var.purview_alert4.metric_namespace
  threshold           = var.purview_alert4.threshold
  aggregation         = var.purview_alert4.aggregation
  operator            = var.purview_alert4.operator
  frequency           = var.purview_alert4.frequency
  window_size         = var.purview_alert4.window_size
}

module "key_vault_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.key_vault_private_endpoint.id
  alert_name          = "${local.baseName1}-kv-vault-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.kv_pe_alert1.description
  metric_name         = var.kv_pe_alert1.metric_name
  metric_namespace    = var.kv_pe_alert1.metric_namespace
  threshold           = var.kv_pe_alert1.threshold
  aggregation         = var.kv_pe_alert1.aggregation
  operator            = var.kv_pe_alert1.operator
  frequency           = var.kv_pe_alert1.frequency
  window_size         = var.kv_pe_alert1.window_size
}

module "key_vault_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.key_vault_private_endpoint.id
  alert_name          = "${local.baseName1}-kv-vault-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.kv_pe_alert2.description
  metric_name         = var.kv_pe_alert2.metric_name
  metric_namespace    = var.kv_pe_alert2.metric_namespace
  threshold           = var.kv_pe_alert2.threshold
  aggregation         = var.kv_pe_alert2.aggregation
  operator            = var.kv_pe_alert2.operator
  frequency           = var.kv_pe_alert2.frequency
  window_size         = var.kv_pe_alert2.window_size
}

module "storage_account_one_blob_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_one_blob_private_endpoint.id
  alert_name          = "${local.baseName1}-dls-blob-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_blob_pe_alert1.description
  metric_name         = var.storage_account_one_blob_pe_alert1.metric_name
  metric_namespace    = var.storage_account_one_blob_pe_alert1.metric_namespace
  threshold           = var.storage_account_one_blob_pe_alert1.threshold
  aggregation         = var.storage_account_one_blob_pe_alert1.aggregation
  operator            = var.storage_account_one_blob_pe_alert1.operator
  frequency           = var.storage_account_one_blob_pe_alert1.frequency
  window_size         = var.storage_account_one_blob_pe_alert1.window_size
}

module "storage_account_one_blob_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_one_blob_private_endpoint.id
  alert_name          = "${local.baseName1}-dls-blob-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_blob_pe_alert2.description
  metric_name         = var.storage_account_one_blob_pe_alert2.metric_name
  metric_namespace    = var.storage_account_one_blob_pe_alert2.metric_namespace
  threshold           = var.storage_account_one_blob_pe_alert2.threshold
  aggregation         = var.storage_account_one_blob_pe_alert2.aggregation
  operator            = var.storage_account_one_blob_pe_alert2.operator
  frequency           = var.storage_account_one_blob_pe_alert2.frequency
  window_size         = var.storage_account_one_blob_pe_alert2.window_size
}

module "storage_account_one_dfs_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_one_dfs_private_endpoint.id
  alert_name          = "${local.baseName1}-dls-dfs-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_dfs_pe_alert1.description
  metric_name         = var.storage_account_one_dfs_pe_alert1.metric_name
  metric_namespace    = var.storage_account_one_dfs_pe_alert1.metric_namespace
  threshold           = var.storage_account_one_dfs_pe_alert1.threshold
  aggregation         = var.storage_account_one_dfs_pe_alert1.aggregation
  operator            = var.storage_account_one_dfs_pe_alert1.operator
  frequency           = var.storage_account_one_dfs_pe_alert1.frequency
  window_size         = var.storage_account_one_dfs_pe_alert1.window_size
}

module "storage_account_one_dfs_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_one_dfs_private_endpoint.id
  alert_name          = "${local.baseName1}-dls-dfs-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_one_dfs_pe_alert2.description
  metric_name         = var.storage_account_one_dfs_pe_alert2.metric_name
  metric_namespace    = var.storage_account_one_dfs_pe_alert2.metric_namespace
  threshold           = var.storage_account_one_dfs_pe_alert2.threshold
  aggregation         = var.storage_account_one_dfs_pe_alert2.aggregation
  operator            = var.storage_account_one_dfs_pe_alert2.operator
  frequency           = var.storage_account_one_dfs_pe_alert2.frequency
  window_size         = var.storage_account_one_dfs_pe_alert2.window_size
}

module "storage_account_two_blob_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_two_blob_private_endpoint.id
  alert_name          = "${local.baseName1}-dls2-blob-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_blob_pe_alert1.description
  metric_name         = var.storage_account_two_blob_pe_alert1.metric_name
  metric_namespace    = var.storage_account_two_blob_pe_alert1.metric_namespace
  threshold           = var.storage_account_two_blob_pe_alert1.threshold
  aggregation         = var.storage_account_two_blob_pe_alert1.aggregation
  operator            = var.storage_account_two_blob_pe_alert1.operator
  frequency           = var.storage_account_two_blob_pe_alert1.frequency
  window_size         = var.storage_account_two_blob_pe_alert1.window_size
}

module "storage_account_two_blob_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_two_blob_private_endpoint.id
  alert_name          = "${local.baseName1}-dls2-blob-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_blob_pe_alert2.description
  metric_name         = var.storage_account_two_blob_pe_alert2.metric_name
  metric_namespace    = var.storage_account_two_blob_pe_alert2.metric_namespace
  threshold           = var.storage_account_two_blob_pe_alert2.threshold
  aggregation         = var.storage_account_two_blob_pe_alert2.aggregation
  operator            = var.storage_account_two_blob_pe_alert2.operator
  frequency           = var.storage_account_two_blob_pe_alert2.frequency
  window_size         = var.storage_account_two_blob_pe_alert2.window_size
}

module "storage_account_two_dfs_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_two_dfs_private_endpoint.id
  alert_name          = "${local.baseName1}-dls2-dfs-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_dfs_pe_alert1.description
  metric_name         = var.storage_account_two_dfs_pe_alert1.metric_name
  metric_namespace    = var.storage_account_two_dfs_pe_alert1.metric_namespace
  threshold           = var.storage_account_two_dfs_pe_alert1.threshold
  aggregation         = var.storage_account_two_dfs_pe_alert1.aggregation
  operator            = var.storage_account_two_dfs_pe_alert1.operator
  frequency           = var.storage_account_two_dfs_pe_alert1.frequency
  window_size         = var.storage_account_two_dfs_pe_alert1.window_size
}

module "storage_account_two_dfs_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.storage_account_two_dfs_private_endpoint.id
  alert_name          = "${local.baseName1}-dls2-dfs-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.storage_account_two_dfs_pe_alert2.description
  metric_name         = var.storage_account_two_dfs_pe_alert2.metric_name
  metric_namespace    = var.storage_account_two_dfs_pe_alert2.metric_namespace
  threshold           = var.storage_account_two_dfs_pe_alert2.threshold
  aggregation         = var.storage_account_two_dfs_pe_alert2.aggregation
  operator            = var.storage_account_two_dfs_pe_alert2.operator
  frequency           = var.storage_account_two_dfs_pe_alert2.frequency
  window_size         = var.storage_account_two_dfs_pe_alert2.window_size
}

module "databricks_brows_auth_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.databricks_brows_auth_private_endpoint.id
  alert_name          = "${local.baseName1}-dbw-browsauth-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.databricks_brows_auth_pe_alert1.description
  metric_name         = var.databricks_brows_auth_pe_alert1.metric_name
  metric_namespace    = var.databricks_brows_auth_pe_alert1.metric_namespace
  threshold           = var.databricks_brows_auth_pe_alert1.threshold
  aggregation         = var.databricks_brows_auth_pe_alert1.aggregation
  operator            = var.databricks_brows_auth_pe_alert1.operator
  frequency           = var.databricks_brows_auth_pe_alert1.frequency
  window_size         = var.databricks_brows_auth_pe_alert1.window_size
}

module "databricks_brows_auth_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.databricks_brows_auth_private_endpoint.id
  alert_name          = "${local.baseName1}-dbw-browsauth-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.databricks_brows_auth_pe_alert2.description
  metric_name         = var.databricks_brows_auth_pe_alert2.metric_name
  metric_namespace    = var.databricks_brows_auth_pe_alert2.metric_namespace
  threshold           = var.databricks_brows_auth_pe_alert2.threshold
  aggregation         = var.databricks_brows_auth_pe_alert2.aggregation
  operator            = var.databricks_brows_auth_pe_alert2.operator
  frequency           = var.databricks_brows_auth_pe_alert2.frequency
  window_size         = var.databricks_brows_auth_pe_alert2.window_size
}

module "databricks_ui_api_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.databricks_ui_api_private_endpoint.id
  alert_name          = "${local.baseName1}-dbw-uiapi-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.databricks_ui_api_pe_alert1.description
  metric_name         = var.databricks_ui_api_pe_alert1.metric_name
  metric_namespace    = var.databricks_ui_api_pe_alert1.metric_namespace
  threshold           = var.databricks_ui_api_pe_alert1.threshold
  aggregation         = var.databricks_ui_api_pe_alert1.aggregation
  operator            = var.databricks_ui_api_pe_alert1.operator
  frequency           = var.databricks_ui_api_pe_alert1.frequency
  window_size         = var.databricks_ui_api_pe_alert1.window_size
}

module "databricks_ui_api_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.databricks_ui_api_private_endpoint.id
  alert_name          = "${local.baseName1}-dbw-uiapi-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.databricks_ui_api_pe_alert2.description
  metric_name         = var.databricks_ui_api_pe_alert2.metric_name
  metric_namespace    = var.databricks_ui_api_pe_alert2.metric_namespace
  threshold           = var.databricks_ui_api_pe_alert2.threshold
  aggregation         = var.databricks_ui_api_pe_alert2.aggregation
  operator            = var.databricks_ui_api_pe_alert2.operator
  frequency           = var.databricks_ui_api_pe_alert2.frequency
  window_size         = var.databricks_ui_api_pe_alert2.window_size
}

module "synapse_sql_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.synapse_sql_private_endpoint.id
  alert_name          = "${local.baseName1}-synw-sql-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_sql_pe_alert1.description
  metric_name         = var.synapse_sql_pe_alert1.metric_name
  metric_namespace    = var.synapse_sql_pe_alert1.metric_namespace
  threshold           = var.synapse_sql_pe_alert1.threshold
  aggregation         = var.synapse_sql_pe_alert1.aggregation
  operator            = var.synapse_sql_pe_alert1.operator
  frequency           = var.synapse_sql_pe_alert1.frequency
  window_size         = var.synapse_sql_pe_alert1.window_size
}

module "synapse_sql_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.synapse_sql_private_endpoint.id
  alert_name          = "${local.baseName1}-synw-sql-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_sql_pe_alert2.description
  metric_name         = var.synapse_sql_pe_alert2.metric_name
  metric_namespace    = var.synapse_sql_pe_alert2.metric_namespace
  threshold           = var.synapse_sql_pe_alert2.threshold
  aggregation         = var.synapse_sql_pe_alert2.aggregation
  operator            = var.synapse_sql_pe_alert2.operator
  frequency           = var.synapse_sql_pe_alert2.frequency
  window_size         = var.synapse_sql_pe_alert2.window_size
}

module "synapse_sql_on_demand_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.synapse_sql_on_demand_private_endpoint.id
  alert_name          = "${local.baseName1}-synw-sqlondemand-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_sql_on_demand_pe_alert1.description
  metric_name         = var.synapse_sql_on_demand_pe_alert1.metric_name
  metric_namespace    = var.synapse_sql_on_demand_pe_alert1.metric_namespace
  threshold           = var.synapse_sql_on_demand_pe_alert1.threshold
  aggregation         = var.synapse_sql_on_demand_pe_alert1.aggregation
  operator            = var.synapse_sql_on_demand_pe_alert1.operator
  frequency           = var.synapse_sql_on_demand_pe_alert1.frequency
  window_size         = var.synapse_sql_on_demand_pe_alert1.window_size
}

module "synapse_sql_on_demand_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.synapse_sql_on_demand_private_endpoint.id
  alert_name          = "${local.baseName1}-synw-sqlondemand-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_sql_on_demand_pe_alert2.description
  metric_name         = var.synapse_sql_on_demand_pe_alert2.metric_name
  metric_namespace    = var.synapse_sql_on_demand_pe_alert2.metric_namespace
  threshold           = var.synapse_sql_on_demand_pe_alert2.threshold
  aggregation         = var.synapse_sql_on_demand_pe_alert2.aggregation
  operator            = var.synapse_sql_on_demand_pe_alert2.operator
  frequency           = var.synapse_sql_on_demand_pe_alert2.frequency
  window_size         = var.synapse_sql_on_demand_pe_alert2.window_size
}

module "synapse_dev_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.synapse_dev_private_endpoint.id
  alert_name          = "${local.baseName1}-synw-dev-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_dev_pe_alert1.description
  metric_name         = var.synapse_dev_pe_alert1.metric_name
  metric_namespace    = var.synapse_dev_pe_alert1.metric_namespace
  threshold           = var.synapse_dev_pe_alert1.threshold
  aggregation         = var.synapse_dev_pe_alert1.aggregation
  operator            = var.synapse_dev_pe_alert1.operator
  frequency           = var.synapse_dev_pe_alert1.frequency
  window_size         = var.synapse_dev_pe_alert1.window_size
}

module "synapse_dev_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.synapse_dev_private_endpoint.id
  alert_name          = "${local.baseName1}-synw-dev-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingApplicationRGName
  description         = var.synapse_dev_pe_alert2.description
  metric_name         = var.synapse_dev_pe_alert2.metric_name
  metric_namespace    = var.synapse_dev_pe_alert2.metric_namespace
  threshold           = var.synapse_dev_pe_alert2.threshold
  aggregation         = var.synapse_dev_pe_alert2.aggregation
  operator            = var.synapse_dev_pe_alert2.operator
  frequency           = var.synapse_dev_pe_alert2.frequency
  window_size         = var.synapse_dev_pe_alert2.window_size
}

module "purview_ingestion_blob_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.purview_ingestion_blob_private_endpoint.id
  alert_name          = "${local.baseName1}-pview-ingestion-blob-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingdataGovernanceRGName
  description         = var.purview_ingestion_blob_pe_alert1.description
  metric_name         = var.purview_ingestion_blob_pe_alert1.metric_name
  metric_namespace    = var.purview_ingestion_blob_pe_alert1.metric_namespace
  threshold           = var.purview_ingestion_blob_pe_alert1.threshold
  aggregation         = var.purview_ingestion_blob_pe_alert1.aggregation
  operator            = var.purview_ingestion_blob_pe_alert1.operator
  frequency           = var.purview_ingestion_blob_pe_alert1.frequency
  window_size         = var.purview_ingestion_blob_pe_alert1.window_size
}

module "purview_ingestion_blob_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.purview_ingestion_blob_private_endpoint.id
  alert_name          = "${local.baseName1}-pview-ingestion-blob-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingdataGovernanceRGName
  description         = var.purview_ingestion_blob_pe_alert2.description
  metric_name         = var.purview_ingestion_blob_pe_alert2.metric_name
  metric_namespace    = var.purview_ingestion_blob_pe_alert2.metric_namespace
  threshold           = var.purview_ingestion_blob_pe_alert2.threshold
  aggregation         = var.purview_ingestion_blob_pe_alert2.aggregation
  operator            = var.purview_ingestion_blob_pe_alert2.operator
  frequency           = var.purview_ingestion_blob_pe_alert2.frequency
  window_size         = var.purview_ingestion_blob_pe_alert2.window_size
}

module "purview_ingestion_blob_pe_alert1" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.purview_ingestion_queue_private_endpoint.id
  alert_name          = "${local.baseName1}-pview-ingestion-queue-pe1-alert1"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingdataGovernanceRGName
  description         = var.purview_ingestion_queue_pe_alert1.description
  metric_name         = var.purview_ingestion_queue_pe_alert1.metric_name
  metric_namespace    = var.purview_ingestion_queue_pe_alert1.metric_namespace
  threshold           = var.purview_ingestion_queue_pe_alert1.threshold
  aggregation         = var.purview_ingestion_queue_pe_alert1.aggregation
  operator            = var.purview_ingestion_queue_pe_alert1.operator
  frequency           = var.purview_ingestion_queue_pe_alert1.frequency
  window_size         = var.purview_ingestion_queue_pe_alert1.window_size
}

module "purview_ingestion_blob_pe_alert2" {
  source              = "../../Modules/alerts/alerts"
  scope               = data.azurerm_private_endpoint_connection.purview_ingestion_queue_private_endpoint.id
  alert_name          = "${local.baseName1}-pview-ingestion-queue-pe1-alert2"
  action_group_id     = module.action_group.action_group_id
  resource_group_name = var.nameConfig.existingdataGovernanceRGName
  description         = var.purview_ingestion_queue_pe_alert2.description
  metric_name         = var.purview_ingestion_queue_pe_alert2.metric_name
  metric_namespace    = var.purview_ingestion_queue_pe_alert2.metric_namespace
  threshold           = var.purview_ingestion_queue_pe_alert2.threshold
  aggregation         = var.purview_ingestion_queue_pe_alert2.aggregation
  operator            = var.purview_ingestion_queue_pe_alert2.operator
  frequency           = var.purview_ingestion_queue_pe_alert2.frequency
  window_size         = var.purview_ingestion_queue_pe_alert2.window_size
}
