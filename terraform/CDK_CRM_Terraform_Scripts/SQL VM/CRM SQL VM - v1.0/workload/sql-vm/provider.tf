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
  subscription_id = "xxxxxxxxxxxxxxxxxx"
}