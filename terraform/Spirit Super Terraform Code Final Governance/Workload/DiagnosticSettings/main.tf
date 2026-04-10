module "diagnostic_setting_databricks_workspace" {
  source                  = "../../Modules/diagnosticSettings/databricksDiagnostics"
  dignosticSettingName    = "${local.baseName1}-dbw-ds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = data.azurerm_databricks_workspace.databricks_workspace.id
}

module "diagnostic_setting_synapse_workspace" {
  source                  = "../../Modules/diagnosticSettings/synapseWorkspaceDiagnostics"
  dignosticSettingName    = "${local.baseName1}-synw-ds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = data.azurerm_synapse_workspace.synapse_workspace.id
}

module "diagnostic_setting_logic_app" {
  source                  = "../../Modules/diagnosticSettings/logicAppDiagnostics"
  dignosticSettingName    = "${local.baseName1}-logic-ds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = data.azurerm_logic_app_workflow.logic_app.id
}

module "diagnostic_setting_key_vault" {
  source                  = "../../Modules/diagnosticSettings/keyVaultDiagnostics"
  dignosticSettingName    = "${local.baseName1}-kv01-ds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = data.azurerm_key_vault.key_vault.id
}

module "diagnostic_setting_storage_account_one" {
  source                  = "../../Modules/diagnosticSettings/storageAccountDiagnostics"
  dignosticSettingName    = "${local.baseName1}dlsds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = data.azurerm_storage_account.storage_account_one.id
}

module "diagnostic_setting_storage_account_two" {
  source                  = "../../Modules/diagnosticSettings/storageAccountDiagnostics"
  dignosticSettingName    = "${local.baseName1}dls2ds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = data.azurerm_storage_account.storage_account_two.id
}

module "diagnostic_setting_purview_account" {
  source                  = "../../Modules/diagnosticSettings/purviewDiagnostics"
  dignosticSettingName    = "${local.baseName1}-pview-ds"
  logAnalyticsWorkspaceId = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  targetResourceId        = var.nameConfig.purviewAccountResourceID
}
