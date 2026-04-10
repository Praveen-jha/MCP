# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Compatible with Azure resources like azurerm_mssql_virtual_machine
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0" # Supports Entra ID role assignments
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0" # Required for enabling Entra authentication on SQL VM
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0" # Used for random_password resources
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
  subscription_id = ""
}

# Configure the AzAPI provider for advanced Azure resource management
provider "azapi" {}
