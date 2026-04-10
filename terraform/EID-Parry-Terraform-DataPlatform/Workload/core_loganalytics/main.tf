# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
}

#Local Block for Resource Naming Conventions
locals {
  log_analytics_workspace_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-log-${var.nameConfig.environment}01")
  hub_shared_rg_name           = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-${var.nameConfig.environment}01")
}

#Data block for Hub Shared Resource Group
data "azurerm_resource_group" "hub_shared_rg" {
  count = var.nameConfig.rg_creation == "existing" ? 1 : 0
  name  = local.hub_shared_rg_name
}

# Creating Log Analytics Workspace
module "log_analytics_workspace" {
  source             = "../../Modules/logAnalyticsWorkspace"
  logWorkspaceName   = local.log_analytics_workspace_name
  location           = var.nameConfig.defaultLocation
  logRetentionInDays = var.log_analytics_workspace.retention_in_days
  logWorkspaceSku    = var.log_analytics_workspace.sku
  rgName             = local.hub_shared_rg_name
  tags               = var.nameConfig.tags
}
