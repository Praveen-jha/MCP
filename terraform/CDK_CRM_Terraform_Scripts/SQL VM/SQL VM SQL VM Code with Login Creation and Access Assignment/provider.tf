terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    azapi = {
      source = "azure/azapi"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

provider "azuread" {
  tenant_id     = ""
  client_id     = ""
  client_secret = ""
}

provider "azurerm" {
  features {}
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
}

provider "azapi" {
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  subscription_id = ""
}
