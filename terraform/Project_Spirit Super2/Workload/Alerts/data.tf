data "azurerm_resource_group" "action_group_rg" {
  name = var.nameConfig.existingApplicationRGName
}

data "azurerm_synapse_workspace" "synapse_workspace" {
  name                = "${local.baseName1}-synw"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_logic_app_workflow" "logic_app" {
  name                = "${local.baseName1}-logic"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_storage_account" "storage_account_one" {
  name                = "${local.baseName1}dls"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_storage_account" "storage_account_two" {
  name                = "${local.baseName1}dls2"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.baseName1}-kv01"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "key_vault_private_endpoint" {
  name                = "${local.baseName1}-kv-vault-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "storage_account_one_blob_private_endpoint" {
  name                = "${local.baseName1}-dls-blob-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "storage_account_one_dfs_private_endpoint" {
  name                = "${local.baseName1}-dls-dfs-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "storage_account_two_blob_private_endpoint" {
  name                = "${local.baseName1}-dls2-blob-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "storage_account_two_dfs_private_endpoint" {
  name                = "${local.baseName1}-dls2-dfs-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "databricks_brows_auth_private_endpoint" {
  name                = "${local.baseName1}-dbw-browsauth-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "databricks_ui_api_private_endpoint" {
  name                = "${local.baseName1}-dbw-uiapi-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "synapse_sql_private_endpoint" {
  name                = "${local.baseName1}-synw-sql-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "synapse_sql_on_demand_private_endpoint" {
  name                = "${local.baseName1}-synw-sqlondemand-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "synapse_dev_private_endpoint" {
  name                = "${local.baseName1}-synw-dev-pe1"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_private_endpoint_connection" "purview_ingestion_blob_private_endpoint" {
  name                = "${local.baseName1}-pview-ingestion-blob-pe1"
  resource_group_name = var.nameConfig.existingdataGovernanceRGName
}

data "azurerm_private_endpoint_connection" "purview_ingestion_queue_private_endpoint" {
  name                = "${local.baseName1}-pview-ingestion-queue-pe1"
  resource_group_name = var.nameConfig.existingdataGovernanceRGName
}
