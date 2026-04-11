# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
}

#Local Block for Resource Naming Conventions
locals {
  hub_network_rg_name          = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-${var.nameConfig.environment}01")
  hub_virtual_network_name     = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vnet-${var.nameConfig.environment}01")
  log_analytics_workspace_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-log-hub01")
  vpngw_pip_name               = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vng-pip-${var.nameConfig.environment}01")
  storage_account_name         = lower("${var.nameConfig.identity}${var.nameConfig.businessunit}strtfstate${var.nameConfig.environment}01")

  virtual_network_diagnostics_name       = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-diag-vnet-${var.nameConfig.environment}01")
  vpngw_pip_diagnostics_name             = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-diag-vng-pip-${var.nameConfig.environment}01")
  storage_account_diagnostics_name       = upper("${var.nameConfig.identity}${var.nameConfig.businessunit}diagstrtfstate${var.nameConfig.environment}01")
  storage_account_blob_diagnostics_name  = upper("${var.nameConfig.identity}${var.nameConfig.businessunit}diagstrtfstateblob${var.nameConfig.environment}01")
  virtual_network_diagnostics = {
    enabled_log = {
      category        = []
      category_groups = ["allLogs"]
    },
    metric = ["AllMetrics"]
  }
  public_ip_diagnostics = {
    enabled_log = {
      category        = []
      category_groups = ["allLogs", "Audit"]
    },
    metric = ["AllMetrics"]
  }
  storage_account_diagnostics = {
    enabled_log = {
      category        = []
      category_groups = []
    },
    metric = ["Transaction"]
  }
  storage_account_service_diagnostics = {
    enabled_log = {
      category        = []
      category_groups = ["allLogs", "Audit"]
    },
    metric = ["Transaction"]
  }
}

#Data block for Hub Network Resource Group
data "azurerm_resource_group" "hub_network_resource_group" {
  count = var.nameConfig.rg_creation == "existing" ? 1 : 0
  name  = local.hub_network_rg_name
}

#Data block for Hub Virtual Network
data "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_virtual_network_name
  resource_group_name = data.azurerm_resource_group.hub_network_resource_group[0].name
}

#Data block for Log Analytics Workspace
data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.hub_network_rg_name
}

#Data block for Public IP
data "azurerm_public_ip" "public_ip" {
  name                = local.vpngw_pip_name
  resource_group_name = local.hub_network_rg_name
}

#Data block for Storage Account
data "azurerm_storage_account" "storage_account" {
  name                = local.storage_account_name
  resource_group_name = local.hub_network_rg_name
}

#Create Diagnostics Settings for Virtual Network
module "virtual_network_diagnostics_settings" {
  source                     = "../../Modules/diagnosticsSettings"
  diagnostic_setting_name    = local.virtual_network_diagnostics_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  target_resource_id         = data.azurerm_virtual_network.hub_vnet.id
  enabled_log                = local.virtual_network_diagnostics.enabled_log
  metric                     = local.virtual_network_diagnostics.metric
}

#Create Diagnostics Settings for Public IP
module "public_ip_diagnostics_settings" {
  source                     = "../../Modules/diagnosticsSettings"
  diagnostic_setting_name    = local.vpngw_pip_diagnostics_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  target_resource_id         = data.azurerm_public_ip.public_ip.id
  enabled_log                = local.public_ip_diagnostics.enabled_log
  metric                     = local.public_ip_diagnostics.metric
}

#Create Diagnostics Settings for Storage Account
module "storage_account_diagnostics_settings" {
  source                     = "../../Modules/diagnosticsSettings"
  diagnostic_setting_name    = local.storage_account_diagnostics_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  target_resource_id         = data.azurerm_storage_account.storage_account.id
  enabled_log                = local.storage_account_diagnostics.enabled_log
  metric                     = local.storage_account_diagnostics.metric
}

#Create Diagnostics Settings for Storage Account Blob
module "storage_account_blob_diagnostics_settings" {
  source                     = "../../Modules/diagnosticsSettings"
  diagnostic_setting_name    = local.storage_account_blob_diagnostics_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  target_resource_id         = "${data.azurerm_storage_account.storage_account.id}/blobServices/default"
  enabled_log                = local.storage_account_service_diagnostics.enabled_log
  metric                     = local.storage_account_service_diagnostics.metric
}
