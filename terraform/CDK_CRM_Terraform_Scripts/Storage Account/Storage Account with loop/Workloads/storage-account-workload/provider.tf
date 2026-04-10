# This file configures the required Terraform version and AzureRM provider with subscription details.
terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
