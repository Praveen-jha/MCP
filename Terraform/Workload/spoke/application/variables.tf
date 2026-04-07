//Common Tags shared accross azure resources
variable "common_tags" {
  description = "common tags that needs to be attatched to the resources"
  type        = map(string)
}

# variable "networking" {
#   type = object({
#     spoke_rg_name        = string
#     spoke_vnet_name      = string
#     dbx_host_subnet      = string
#     dbx_container_subnet = string
#     spoke_pep_subnet     = string
#     spoke_compute_subnet = string
#   })
# }
variable "dns_zones_id" {
  type = object({
    storage_dfs_id               = string
    storage_blob_id              = string
    storage_file_share_id        = string
    storage_table_id             = string
    storage_queue_id             = string
    azure_databricks_dns_zone_id = string
    service_bus_zone_id          = string
    key_vault_zone_id            = string
    dataFactory_zone_id          = string
    logicapp_zone_id             = string
  })
}
//RG Names; These are the names of the RGs that were deployed as part of the Networking Workload.
variable "rg_name" {
  description = "name of the Resource Group"
  type        = string
}

//Name of the network (VNETs and Subnet) that was deployed with the Networking Workload. Required to fetch details.
variable "vnet_name" {
  description = "name of the Virtual Network"
  type        = string
}
variable "private_endpoint_subnet_name" {
  description = "name of the private endpoint subnet"
  type        = string
}
variable "databricks_host_subnet_name" {
  description = "name of the databricks host subnet"
  type        = string
}
variable "databricks_container_subnet_name" {
  description = "name of the databricks container subnet"
  type        = string
}
variable "logicapp_integration_subnet_name" {
  description = "name of the Logic App Vnet integration subnet"
  type        = string
}
//The public_network_access_enabled variable controls weather public access is allowed on all the PaaS services or not.
variable "public_network_access_enabled" {
  description = "is public network access enabled on the PaaS resources? Defaults to False if no value is passed."
  type        = bool
  # default     = false
}
//PaaS Resources Variables
variable "keyvault_name" {
  description = "name of the key vault that needs to be deployed"
  type        = string
}
variable "storage_account_name" {
  description = "name of the storage account"
  type        = string
}
variable "eventhub_namespace_name" {
  description = "name of the eventhub namespace"
  type        = string
}
# variable "iothub_name" {
#   description = "name of the iot Hub"
#   type        = string
# }
variable "data_factory_name" {
  description = "(Required) Specifies the name of the Data Factory"
  type        = string
}
variable "adb_connector_name" {
  description = "The name of the Databricks Access Connector."
  type        = string
}
variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}
variable "databricks_managed_rg_name" {
  description = "Name of the managed azure databricks resource group"
  type        = string
}
variable "logic_app_name" {
  description = "Name of the Logic App"
}
variable "logic_app_storage_account_name" {
  description = "Name of the Storage Account for Logic App"
}
variable "logic_app_service_plan_name" {
  description = "Name of the Storage Account for Logic App"
}
//Private Endpoint names for the PaaS services
variable "datafactory_dataFactory_private_endpoint_name" {
  description = "name of the datafactory 'dataFactory' private endpint"
  type        = string
}
variable "storage_account_blob_private_endpoint_name" {
  description = "name of the storage account 'blob' private endpoint"
  type        = string
}
variable "storage_account_dfs_private_endpoint_name" {
  description = "name of the storage account 'dfs' private endpoint"
  type        = string
}
variable "keyvault_vault_private_endpoint_name" {
  description = "name of the azure key vault 'vault' private endpoint"
  type        = string
}
variable "databricks_ui_api_private_endpoint_name" {
  description = "name of the databricks 'ui-api' private endpoint"
  type        = string
}
variable "databricks_browser_auth_private_endpoint_name" {
  description = "name of the databricks 'browser_auth' private endpoint"
  type        = string
}
variable "eventhub_namespace_private_endpoint_name" {
  description = "name of the eventhub 'namespace' private endpoint"
  type        = string
}
variable "logic_app_private_endpoint_name" {
  description = "name of the logic app private endpoint"
  type        = string
}
//Existing Log Analytics Workspace ID. Required for the configuration of Diagnostic Settings.
variable "log_analytics_workspace_id" {
  description = "Existing Log Analytics Workspace ID that needs to be configured on the Azure Services"
  type        = string
}
