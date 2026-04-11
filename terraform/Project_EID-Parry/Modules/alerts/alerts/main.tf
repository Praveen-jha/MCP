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
  action_group_name                        = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-ag-01")
  hub_sha_virtual_machine_alert_name       = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmsha-ar-hub01")
  non_prod_shir_virtual_machine_alert_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmshir-ar-npd01")
  non_prod_odgw_virtual_machine_alert_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmodgw-ar-npd01")
  prod_shir_virtual_machine_alert_name     = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmshir-ar-prd01")
  prod_odgw_virtual_machine_alert_name     = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmodgw-ar-prd01")
  virtual_network_gateway_alert_name       = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vng-ar-hub01")
  non_prod_data_factory_alert_name         = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-adf-ar-npd01")
  prod_data_factory_alert_name             = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-adf-ar-prd01")
  hub_rg_budget_name                       = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-budget-hub01")
  non_prod_rg_budget_name                  = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-budget-npd01")
  prod_rg_budget_name                      = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-budget-prd01")
}

#Data block to Fetch Hub Resource Group
data "azurerm_resource_group" "hub_resource_group" {
  name = var.hub_resource_group_name
}

#Data block to Fetch Non Prod Resource Group
data "azurerm_resource_group" "non_prod_resource_group" {
  name = var.non_prod_resource_group_name
}

#Data block to Fetch Prod Resource Group
data "azurerm_resource_group" "prod_resource_group" {
  name = var.prod_resource_group_name
}

# Data block to Fetch Hub SHA Virtual Machine.
data "azurerm_virtual_machine" "hub_sha_virtual_machine" {
  name                = var.hub_sha_virtual_machine_name
  resource_group_name = var.hub_resource_group_name
}

# Data block to Fetch Non Prod SHIR Virtual Machine.
data "azurerm_virtual_machine" "non_prod_shir_virtual_machine" {
  name                = var.non_prod_shir_virtual_machine_name
  resource_group_name = var.non_prod_resource_group_name
}

# Data block to Fetch Non Prod ODGW Virtual Machine.
data "azurerm_virtual_machine" "non_prod_odgw_virtual_machine" {
  name                = var.non_prod_odgw_virtual_machine_name
  resource_group_name = var.non_prod_resource_group_name
}

# Data block to Fetch Prod SHIR Virtual Machine.
data "azurerm_virtual_machine" "prod_shir_virtual_machine" {
  name                = var.prod_shir_virtual_machine_name
  resource_group_name = var.prod_resource_group_name
}

# Data block to Fetch Prod ODGW Virtual Machine.
data "azurerm_virtual_machine" "prod_odgw_virtual_machine" {
  name                = var.prod_odgw_virtual_machine_name
  resource_group_name = var.prod_resource_group_name
}

#Data block for Virtual Network Gateway
data "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = var.virtual_network_gateway_name
  resource_group_name = var.hub_resource_group_name
}

# Data block to Fetch Non Prod Data Factory.
data "azurerm_data_factory" "non_prod_data_factory" {
  name                = var.non_prod_data_factory_name
  resource_group_name = var.non_prod_resource_group_name
}

# Data block to Fetch Non Prod Data Factory.
data "azurerm_data_factory" "prod_data_factory" {
  name                = var.prod_data_factory_name
  resource_group_name = var.prod_resource_group_name
}

# Module for Action Group. 
module "action_group" {
  source                  = "../../modules/moniter-action-group"
  resource_group_name     = var.hub_resource_group_name
  action_group_name       = local.action_group_name
  action_group_short_name = var.action_group_details.short_name
  email_details           = var.action_group_details.email_details
}

# Module to create Hub SHA Virtual Machine moniter metric alerts.
module "hub_sha_vm_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_virtual_machine.hub_sha_virtual_machine.name
  alert_name          = local.hub_sha_virtual_machine_alert_name
  resource_group_name = var.hub_resource_group_name
  alert_severity      = var.vm_alerts_details.alert_severity
  alert_frequency     = var.vm_alerts_details.alert_frequency
  alert_window_size   = var.vm_alerts_details.alert_window_size
  alert_description   = var.vm_alerts_details.alert_description
  alert_enabled       = var.vm_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_virtual_machine.hub_sha_virtual_machine.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.vm_metric_criteria
}

# Module to create Non Prod SHIR Virtual Machine moniter metric alerts.
module "non_prod_shir_vm_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_virtual_machine.non_prod_shir_virtual_machine.name
  alert_name          = local.non_prod_shir_virtual_machine_alert_name
  resource_group_name = var.non_prod_resource_group_name
  alert_severity      = var.vm_alerts_details.alert_severity
  alert_frequency     = var.vm_alerts_details.alert_frequency
  alert_window_size   = var.vm_alerts_details.alert_window_size
  alert_description   = var.vm_alerts_details.alert_description
  alert_enabled       = var.vm_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_virtual_machine.non_prod_shir_virtual_machine.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.vm_metric_criteria
}

# Module to create Non Prod ODGW Virtual Machine moniter metric alerts.
module "non_prod_odgw_vm_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_virtual_machine.non_prod_odgw_virtual_machine_name.name
  alert_name          = local.non_prod_odgw_virtual_machine_alert_name
  resource_group_name = var.non_prod_resource_group_name
  alert_severity      = var.vm_alerts_details.alert_severity
  alert_frequency     = var.vm_alerts_details.alert_frequency
  alert_window_size   = var.vm_alerts_details.alert_window_size
  alert_description   = var.vm_alerts_details.alert_description
  alert_enabled       = var.vm_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_virtual_machine.non_prod_odgw_virtual_machine_name.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.vm_metric_criteria
}

# Module to create Prod SHIR Virtual Machine moniter metric alerts.
module "prod_shir_vm_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_virtual_machine.prod_shir_virtual_machine.name
  alert_name          = local.prod_shir_virtual_machine_alert_name
  resource_group_name = var.prod_resource_group_name
  alert_severity      = var.vm_alerts_details.alert_severity
  alert_frequency     = var.vm_alerts_details.alert_frequency
  alert_window_size   = var.vm_alerts_details.alert_window_size
  alert_description   = var.vm_alerts_details.alert_description
  alert_enabled       = var.vm_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_virtual_machine.prod_shir_virtual_machine.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.vm_metric_criteria
}

# Module to create Prod ODGW Virtual Machine moniter metric alerts.
module "prod_odgw_vm_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_virtual_machine.prod_odgw_virtual_machine_name.name
  alert_name          = local.prod_odgw_virtual_machine_alert_name
  resource_group_name = var.prod_resource_group_name
  alert_severity      = var.vm_alerts_details.alert_severity
  alert_frequency     = var.vm_alerts_details.alert_frequency
  alert_window_size   = var.vm_alerts_details.alert_window_size
  alert_description   = var.vm_alerts_details.alert_description
  alert_enabled       = var.vm_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_virtual_machine.prod_odgw_virtual_machine_name.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.vm_metric_criteria
}

# Module to create Virtual Network Gateway moniter metric alerts.
module "virtual_network_gateway_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_virtual_network_gateway.virtual_network_gateway.name
  alert_name          = local.virtual_network_gateway_alert_name
  resource_group_name = var.hub_resource_group_name
  alert_severity      = var.vpn_alerts_details.alert_severity
  alert_frequency     = var.vpn_alerts_details.alert_frequency
  alert_window_size   = var.vpn_alerts_details.alert_window_size
  alert_description   = var.vpn_alerts_details.alert_description
  alert_enabled       = var.vpn_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_virtual_network_gateway.virtual_network_gateway.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.vpn_metric_criteria
}

# Module to create Non Prod Data Factory moniter metric alerts.
module "non_prod_data_factory_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_data_factory.non_prod_data_factory.name
  alert_name          = local.non_prod_data_factory_alert_name
  resource_group_name = var.non_prod_resource_group_name
  alert_severity      = var.data_factory_alerts_details.alert_severity
  alert_frequency     = var.data_factory_alerts_details.alert_frequency
  alert_window_size   = var.data_factory_alerts_details.alert_window_size
  alert_description   = var.data_factory_alerts_details.alert_description
  alert_enabled       = var.data_factory_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_data_factory.non_prod_data_factory.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.data_factory_metric_criteria
}

# Module to create Prod Data Factory moniter metric alerts.
module "prod_data_factory_metric_alert" {
  source              = "../../modules/moniter-metric-alert"
  resource_name       = data.azurerm_data_factory.prod_data_factory.name
  alert_name          = local.prod_data_factory_alert_name
  resource_group_name = var.prod_resource_group_name
  alert_severity      = var.data_factory_alerts_details.alert_severity
  alert_frequency     = var.data_factory_alerts_details.alert_frequency
  alert_window_size   = var.data_factory_alerts_details.alert_window_size
  alert_description   = var.data_factory_alerts_details.alert_description
  alert_enabled       = var.data_factory_alerts_details.alert_enabled
  scopes_ids          = [data.azurerm_data_factory.prod_data_factory.id]
  action_group_id     = module.action_group.id
  metric_criteria     = var.data_factory_metric_criteria
}

#Module for creating Budget for Hub Resource Group
module "hub_rg_budget" {
  source                   = "../../modules/resource-group-budget"
  budget_name              = local.hub_rg_budget_name
  budget_resource_group_id = data.azurerm_resource_group.hub_resource_group.id
  budget_amount            = var.budget_amount
  budget_time_grain        = var.budget_time_grain
  budget_start_date        = var.budget_start_date
  budget_end_date          = var.budget_end_date
  budget_notifications     = var.budget_notifications
  contact_groups           = [module.action_group.id]
}

#Module for creating Budget for Non Prod Resource Group
module "hub_rg_budget" {
  source                   = "../../modules/resource-group-budget"
  budget_name              = local.non_prod_rg_budget_name
  budget_resource_group_id = data.azurerm_resource_group.non_prod_resource_group.id
  budget_amount            = var.budget_amount
  budget_time_grain        = var.budget_time_grain
  budget_start_date        = var.budget_start_date
  budget_end_date          = var.budget_end_date
  budget_notifications     = var.budget_notifications
  contact_groups           = [module.action_group.id]
}

#Module for creating Budget for Prod Resource Group
module "hub_rg_budget" {
  source                   = "../../modules/resource-group-budget"
  budget_name              = local.prod_rg_budget_name
  budget_resource_group_id = data.azurerm_resource_group.prod_resource_group.id
  budget_amount            = var.budget_amount
  budget_time_grain        = var.budget_time_grain
  budget_start_date        = var.budget_start_date
  budget_end_date          = var.budget_end_date
  budget_notifications     = var.budget_notifications
  contact_groups           = [module.action_group.id]
}
