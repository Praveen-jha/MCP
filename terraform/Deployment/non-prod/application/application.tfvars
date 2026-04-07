// "-t"/"t" has been added at the end of all the names temporarily
// to avoid the "name already taken" issue when the script is used for deployment
common_tags = {
  "ApplicationName" = "databricks"
  "ProjectName"     = "databricks"
  "Environment"     = "NPROD"
  "CreationDate"    = "20-08-2025"
  "CreatedBy"       = "ITSystems"
  "BusinessOwner"   = "analytics team"
  "ApplicationTier" = "T2"
  "Department"      = "IMT"
}
dns_zones_id = {
  storage_dfs_id               = ""
  storage_blob_id              = ""
  storage_file_share_id        = ""
  storage_table_id             = ""
  storage_queue_id             = ""
  azure_databricks_dns_zone_id = ""
  service_bus_zone_id          = ""
  key_vault_zone_id            = ""
  dataFactory_zone_id          = ""
  logicapp_zone_id             = ""
}

//Names of the RGs that are already created
rg_name = "rg-dpw-nprod-qc-01"

//Name of the Virtual Network that is already created
vnet_name = "vnet-dbw-nprod-qc-01"

//Names of the Subnets that are already created
private_endpoint_subnet_name     = "snet-dpw-pe-nprod-qc-01"
databricks_host_subnet_name      = "snet-dpw-host-nprod-qc-01"
databricks_container_subnet_name = "snet-dpw-container-nprod-qc-01"
logicapp_integration_subnet_name = "snet-dpw-logicapp-nprod-qc-01"
//public network access status for all the paas resources
public_network_access_enabled = false

//Name of the Key Vault that is going to be deployed
keyvault_name = "kv-dbw-nprod-qc-01"

//Name of the Storage Account that is going to be deployed
storage_account_name = "stgdpnprodqc01"

//Name of the Event Hub namespace that is going to be deployed
eventhub_namespace_name = "evhns-dbw-nprod-qc-01"

//Name of the Azure Data Factory that is going to be deployed
data_factory_name = "adf-dbw-nprod-qc-01"

//Name of the Azure Databricks Access Connector that is going to be deployed
adb_connector_name = "ac-dbw-nprod-qc-01"

//Name of the Azure Databricks Workspace that is going to be deployed
databricks_workspace_name = "data-dbw-nprod-qc-01"

//Name of the Managed Resource Group that is going to be created as a part of Azure Databricks Workspace deployment
databricks_managed_rg_name = "rg-dbw-mgt-dp-nprod-qc-01"

//Object Id of the Log Analytics Workspace that is going to be configured in the diagnostic settings of the paas resources

log_analytics_workspace_id = " -53b8-4151-adf8-98325aa865a4/resourceGroups/rg-monitor-hub-qc-01/providers/Microsoft.OperationalInsights/workspaces/law-hub-qc-01"


//Name of the Logic App that will be created
logic_app_name = "logic-dbw-nprod-qc-01"

//Name of the Storage Account that is required for the deployment of Logic App
logic_app_storage_account_name = "stgdplanprodqc01"

//Name of the App Service Plan for Logic App
logic_app_service_plan_name = "asp-dbw-la-nprod-qc-01"

//Names of the Private Endpoints that are needed to be created
datafactory_dataFactory_private_endpoint_name = "pe-adf-dbw-nprod-qc-01"
storage_account_blob_private_endpoint_name    = "pep-blob-dbw-stgdpnprodqc01"
storage_account_dfs_private_endpoint_name     = "pep-dfs-dbw-stgdpnprodqc01"
keyvault_vault_private_endpoint_name          = "pe-kv-dbw-nprod-qc-01"
databricks_ui_api_private_endpoint_name       = "pep-uiapi-dbw-dp-nprod-qc-01"
databricks_browser_auth_private_endpoint_name = "pep-auth-dbw-dp-nprod-qc-01"
eventhub_namespace_private_endpoint_name      = "pe-evhns-dbw-nprod-qc-01"
logic_app_private_endpoint_name               = "pep-logic-dbw-nprod-qc-01"
