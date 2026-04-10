# Configure Terraform provider versions and settings
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

# Configure the Azure provider for the main subscription
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Configure the Azure provider for the VM image hub subscription
provider "azurerm" {
  alias           = "vm-image-hub"
  subscription_id = "38e29007-266c-4c03-8448-fe1d3350b07d"
  features {}
}

# Configure the AzAPI provider for advanced Azure resource management
provider "azapi" {}