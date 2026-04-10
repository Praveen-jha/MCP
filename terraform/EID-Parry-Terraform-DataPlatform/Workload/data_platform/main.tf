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

  spoke_rg_name                = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-${var.nameConfig.environment}01")
  spoke_virtual_network_name   = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vnet-${var.nameConfig.environment}01")
  subnet_compute_name          = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-snetcmp-${var.nameConfig.environment}01")
  subnet_private_endpoint_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-snetpe-${var.nameConfig.environment}01")
  key_vault_name               = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-akv-${var.nameConfig.environment}01")
  data_factory_name            = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-adf-${var.nameConfig.environment}01")
  fabric_capacity_name         = lower("${var.nameConfig.identity}${var.nameConfig.businessunit}fabr${var.nameConfig.environment}01")

  key_vault_diagnostics_name    = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-diag-akv-${var.nameConfig.environment}01")
  data_factory_diagnostics_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-diag-adf-${var.nameConfig.environment}01")

  log_analytics_workspace_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-log-hub01")
  hub_shared_rg_name           = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-hub01")

  key_vault_diagnostics = {
    enabled_log = {
      category        = []
      category_groups = ["allLogs", "Audit"]
    },
    metric = ["AllMetrics"]
  }

  data_factory_diagnostics = {
    enabled_log = {
      category        = []
      category_groups = ["allLogs"]
    },
    metric = ["AllMetrics"]
  }

  //configurational details of Azure Key Vault
  keyvault = {
    kv_sku_name                 = "standard" //Possible values are "standard" and "premium"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 90    //No. of Days. Possible values are between 7 and 90
    purge_protection_enabled    = false //purge protection is disabled so that keyvault can be recreated with the same name during the dev and test environment
    enable_rbac_authorization   = true
  }

  //configurational details of azure data factory
  data_factory = {
    managed_virtual_network_enabled = false
    identity_type                   = "SystemAssigned"
  }

  private_endpoints = {
    dataFactory = {
      name                            = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-pepdf-${var.nameConfig.environment}01")
      subresource_name                = ["dataFactory"]
      custom_network_interface_name   = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-pepdf-nic-${var.nameConfig.environment}01")
      private_service_connection_name = "datafactory-private-service-connection-01"
      private_connection_resource_id  = module.data_factory.data_factory_id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
    }
    vault = {
      name                            = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-pepakv-${var.nameConfig.environment}01")
      subresource_name                = ["vault"]
      custom_network_interface_name   = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-pepakv-nic-${var.nameConfig.environment}01")
      private_service_connection_name = "vault-private-service-connection-01"
      private_connection_resource_id  = module.keyvault.keyvault.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
    }
  }
}


#Data block for Spoke Resource Group
data "azurerm_resource_group" "spoke_resource_group" {
  count = var.nameConfig.rg_creation == "existing" ? 1 : 0
  name  = local.spoke_rg_name
}


#Data block for Spoke Virtual Network
data "azurerm_virtual_network" "spoke_vnet" {
  name                = local.spoke_virtual_network_name
  resource_group_name = data.azurerm_resource_group.spoke_resource_group[0].name
}


#Data block for Private Endpoint Subnet
data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = local.subnet_private_endpoint_name
  virtual_network_name = data.azurerm_virtual_network.spoke_vnet.name
  resource_group_name  = data.azurerm_resource_group.spoke_resource_group[0].name
}

#Data block for Log Analytics Workspace
data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.hub_shared_rg_name
}


# Creating Key Vault
module "keyvault" {
  source                         = "../../Modules/keyVault/keyVault"
  key_vault_name                 = local.key_vault_name
  rg_name                        = local.spoke_rg_name
  location                       = var.nameConfig.defaultLocation
  kv_sku_name                    = local.keyvault.kv_sku_name
  enable_rbac_authorization      = local.keyvault.enable_rbac_authorization
  kv_enabled_for_disk_encryption = local.keyvault.enabled_for_disk_encryption
  kv_purge_protection_enabled    = local.keyvault.purge_protection_enabled
  kv_soft_delete_retention_days  = local.keyvault.soft_delete_retention_days
  public_network_access_enabled  = var.public_network_access_enabled
  kv_tags                        = var.nameConfig.tags
}


# Creating Data Factory
module "data_factory" {
  source                          = "../../Modules/dataFactory/azureDataFactory"
  data_factory_name               = local.data_factory_name
  data_factory_location           = var.nameConfig.defaultLocation
  data_factory_rg                 = local.spoke_rg_name
  public_network_enabled          = var.public_network_access_enabled
  managed_virtual_network_enabled = local.data_factory.managed_virtual_network_enabled
  identity_type                   = local.data_factory.identity_type
  tags                            = var.nameConfig.tags
}


# Creating Fabric Capacity
module "fabric_capacity" {
  source                            = "../../Modules/fabricCapacity"
  fabric_cap_name                   = local.fabric_capacity_name
  fabric_cap_rg_name                = local.spoke_rg_name
  fabric_cap_location               = var.nameConfig.defaultLocation
  fabric_cap_sku                    = var.fabric_capacity.fabric_capacity_sku
  fabric_cap_administration_members = var.fabric_capacity.fabric_capacity_administration_members
  fabric_cap_tags                   = var.nameConfig.tags
}

# Creating Private Endpoints
module "private_endpoints" {
  source                               = "../../Modules/networking/privateEndpoint"
  for_each                             = local.private_endpoints
  private_endpoint_name                = each.value.name
  custom_network_interface_name        = each.value.custom_network_interface_name
  subnet_endpoint_id                   = each.value.subnet_id
  private_connection_resource_id       = each.value.private_connection_resource_id
  private_connection_subresource_names = each.value.subresource_name
  private_service_connection_name      = each.value.private_service_connection_name
  resource_group_name                  = local.spoke_rg_name
  location                             = var.nameConfig.defaultLocation
  tags                                 = var.nameConfig.tags
  depends_on                           = [module.data_factory, module.keyvault]
}

#Creating Diagnostics Settings for Spoke Key Vault
module "key_vault_diagnostics_settings" {
  source                     = "../../Modules/diagnosticsSettings"
  diagnostic_setting_name    = local.key_vault_diagnostics_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  target_resource_id         = module.keyvault.key_vault_id
  enabled_log                = local.key_vault_diagnostics.enabled_log
  metric                     = local.key_vault_diagnostics.metric
}

#Creating Diagnostics Settings for Spoke Data Factory
module "data_factory_diagnostics_settings" {
  source                     = "../../Modules/diagnosticsSettings"
  diagnostic_setting_name    = local.data_factory_diagnostics_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  target_resource_id         = module.data_factory.data_factory_id
  enabled_log                = local.data_factory_diagnostics.enabled_log
  metric                     = local.data_factory_diagnostics.metric
}
