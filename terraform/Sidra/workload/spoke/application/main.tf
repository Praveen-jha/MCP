module "keyvault" {
  source                         = "../../../Modules/keyVault/keyVault"
  key_vault_name                 = var.keyvault_name
  rg_name                        = var.rg_name
  location                       = local.location_primary
  kv_sku_name                    = local.keyvault.kv_sku_name
  enable_rbac_authorization      = local.keyvault.enable_rbac_authorization
  kv_enabled_for_disk_encryption = local.keyvault.enabled_for_disk_encryption
  kv_purge_protection_enabled    = local.keyvault.purge_protection_enabled
  kv_soft_delete_retention_days  = local.keyvault.soft_delete_retention_days
  public_network_access_enabled  = var.public_network_access_enabled
  kv_tags                        = var.common_tags
}
module "storage_account" {
  source                            = "../../../Modules/storageAccount"
  storage_account_name              = var.storage_account_name
  rg_name                           = var.rg_name
  location                          = local.location_primary
  public_network_access_enabled     = var.public_network_access_enabled
  account_tier                      = local.storage_account.account_tier
  account_kind                      = local.storage_account.account_kind
  account_replication_type          = local.storage_account.account_replication_type
  is_hns_enabled                    = local.storage_account.is_hns_enabled
  shared_access_key_enabled         = local.storage_account.shared_access_key_enabled
  storage_account_identity_type     = local.storage_account.identity_type
  infrastructure_encryption_enabled = local.storage_account.infrastructure_encryption_enabled
  tags                              = var.common_tags
}
module "eventhub_namespace" {
  source                                           = "../../../Modules/eventhub"
  evenhub_namespace_name                           = var.eventhub_namespace_name
  evenhub_namespace_rg                             = var.rg_name
  eventhub_namespace_location                      = local.location_primary
  evenhub_namespace_sku                            = local.eventhub_namespace.sku
  eventhub_namespace_capacity                      = local.eventhub_namespace.capacity
  eventhub_namespace_auto_inflate_enabled          = local.eventhub_namespace.auto_inflate_enabled
  eventhub_namespace_max_throughput_units          = local.eventhub_namespace.max_throughput_units
  eventhub_namespace_public_network_access_enabled = var.public_network_access_enabled
  tags                                             = var.common_tags
}

module "data_factory" {
  source                          = "../../../Modules/dataFactory/azureDataFactory"
  data_factory_name               = var.data_factory_name
  data_factory_location           = local.location_primary
  data_factory_rg                 = var.rg_name
  public_network_enabled          = var.public_network_access_enabled
  managed_virtual_network_enabled = local.data_factory.managed_virtual_network_enabled
  identity_type                   = local.data_factory.identity_type
  tags                            = var.common_tags
}
module "databricks_access_connector" {
  source                 = "../../../Modules/databricks/accessConnector"
  adb_connector_name     = var.adb_connector_name
  adb_connector_rg       = var.rg_name
  adb_connector_location = local.location_primary
  identity_type          = local.databricks_access_connector.identity_type
  tags                   = var.common_tags
}
module "databricks_workspace" {
  source                            = "../../../Modules/databricks/workspace"
  databricks_workspace_name         = var.databricks_workspace_name
  databricks_workspace_rg           = var.rg_name
  databricks_workspace_location     = local.location_primary
  databricks_workspace_sku          = local.databricks_workspace.sku
  databricks_managed_rg             = var.databricks_managed_rg_name
  public_network_enabled            = var.public_network_access_enabled
  databricks_nsg_rules_required     = local.databricks_workspace.databricks_nsg_rules_required
  databricks_custom_parameters      = local.databricks_workspace.custom_parameters
  infrastructure_encryption_enabled = local.databricks_workspace.infrastructure_encryption_enabled
  tags                              = var.common_tags
}

module "logic_app" {
  source                            = "../../../Modules/LogicApp"
  resource_group_name               = var.rg_name
  location                          = local.location_primary
  storage_account_name              = var.logic_app_storage_account_name
  service_plan_name                 = local.logic_app.service_plan_name
  logic_app_name                    = var.logic_app_name
  os_type                           = local.logic_app.os_type
  sku_name                          = local.logic_app.sku
  account_tier                      = local.logic_app.account_tier
  account_replication_type          = local.logic_app.account_replication_type
  logic_app_subnet_id               = data.azurerm_subnet.logic_app_subnet.id
  logic_app_identity_type           = local.logic_app.identity_type
  logic_app_public_access_enabled   = var.public_network_access_enabled ? "Enabled" : "Disabled"
  storage_accoun_content_share_name = local.logic_app.content_share_name
  storage_pe_subnet_id              = data.azurerm_subnet.private_endpoint_subnet.id
  functions_worker_runtime          = local.logic_app.functions_worker_runtime
  private_dns_zone_ids              = local.logic_app.private_dns_zone_ids

}

module "private_endpoints" {
  source                               = "../../../Modules/networking/privateEndpoint"
  for_each                             = local.private_endpoints
  private_endpoint_name                = each.value.name
  resource_group_name                  = each.value.resource_group_name
  location                             = each.value.location
  custom_network_interface_name        = each.value.custom_network_interface_name
  subnet_endpoint_id                   = each.value.subnet_id
  private_connection_resource_id       = each.value.private_connection_resource_id
  private_connection_subresource_names = each.value.subresource_name
  private_service_connection_name      = each.value.private_service_connection_name
  private_dns_zone_group_name          = each.value.private_dns_zone_group_name
  private_dns_zone_ids                 = [each.value.private_dns_zone_ids]
  tags                                 = var.common_tags
  depends_on                           = [module.data_factory, module.databricks_workspace, module.eventhub_namespace, module.keyvault, module.storage_account]
}

module "databricks_browser_auth_private_endpoint" {
  source                               = "../../../Modules/networking/privateEndpoint"
  private_endpoint_name                = local.databricks_browser_auth_private_endpoint.name
  resource_group_name                  = local.databricks_browser_auth_private_endpoint.resource_group_name
  location                             = local.databricks_browser_auth_private_endpoint.location
  custom_network_interface_name        = local.databricks_browser_auth_private_endpoint.custom_network_interface_name
  subnet_endpoint_id                   = local.databricks_browser_auth_private_endpoint.subnet_id
  private_connection_resource_id       = local.databricks_browser_auth_private_endpoint.private_connection_resource_id
  private_connection_subresource_names = local.databricks_browser_auth_private_endpoint.subresource_name
  private_service_connection_name      = local.databricks_browser_auth_private_endpoint.private_service_connection_name
  tags                                 = var.common_tags
  depends_on                           = [module.private_endpoints]
  private_dns_zone_group_name          = local.databricks_browser_auth_private_endpoint.private_dns_zone_group_name
  private_dns_zone_ids                 = [local.databricks_browser_auth_private_endpoint.private_dns_zone_ids]

}


module "diagnostic_settings" {
  source                  = "../../../Modules/diagnosticSettings"
  for_each                = local.diagnostic_settings
  dignosticSettingName    = each.value.name
  logAnalyticsWorkspaceId = var.log_analytics_workspace_id
  targetResourceId        = each.value.target_resource_id
  enabledLogs             = each.value.category_group
  metric                  = each.value.metric
  depends_on              = [module.data_factory, module.databricks_workspace, module.eventhub_namespace]
}
