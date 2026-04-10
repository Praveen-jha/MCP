terraform {
  required_version = ">= 1.4.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.28.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.14.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
