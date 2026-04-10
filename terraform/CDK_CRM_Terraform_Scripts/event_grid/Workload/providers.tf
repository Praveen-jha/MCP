# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.22.0"
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
  subscription_id = "bee9e5cf-9110-4e06-a415-36c9941e995e"
}