variable "nameConfig" {
  type = object({
    defaultLocation              = string
    tags                         = map(string)
    existingdataGovernanceRGName = string
    existingApplicationRGName    = string
    existingVnetName             = string
    deploymentEnvironment        = string
    identity                     = string
    identity2                    = string
    index                        = number
    publicNetworkAccessEnabled   = bool
    purviewResourceID            = string
  })
  description = "Variable to Provide Values required for the Deployment, e.g., Location, Tags, Environment,etc."
}

variable "email_receiver" {
  type = map(object({
    name          = string
    email_address = string
  }))
  description = "(Optional) One or more email_receiver blocks having name and email address of the receiver."
}

variable "key_vault_alert" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Key Vault Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_alert3" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_alert4" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_alert3" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_alert4" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_workspace_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Workspace Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_workspace_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Workspace Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_workspace_alert3" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Workspace Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "logic_app_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Logic App Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "logic_app_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Logic App Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "logic_app_alert3" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Logic App Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "logic_app_alert4" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Logic App Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "logic_app_alert5" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Logic App Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "logic_app_alert6" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Logic App Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "logic_app_alert7" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Logic App Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_alert3" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_alert4" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Account Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "kv_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Key Vault Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "kv_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Key Vault Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_blob_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_blob_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_dfs_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_one_dfs_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_blob_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_blob_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_dfs_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "storage_account_two_dfs_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Storage Account Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "databricks_brows_auth_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Databricks Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "databricks_brows_auth_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Databricks Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "databricks_ui_api_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Databricks Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "databricks_ui_api_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Databricks Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_sql_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Analytics Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_sql_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Analytics Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_sql_on_demand_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Analytics Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_sql_on_demand_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Analytics Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_dev_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Analytics Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "synapse_dev_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Synapse Analytics Workspace Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_ingestion_blob_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Ingestion Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_ingestion_blob_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Ingestion Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_ingestion_queue_pe_alert1" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Ingestion Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}

variable "purview_ingestion_queue_pe_alert2" {
  type = object({
    description      = string
    metric_name      = string
    metric_namespace = string
    threshold        = number
    aggregation      = string
    operator         = string
    frequency        = string
    window_size      = string
  })
  description = "Variable to Provide Values required for the Purview Ingestion Private Endpoint Alert Deployment, e.g., Description, Metric Name, Metric Namespace,etc."
}
