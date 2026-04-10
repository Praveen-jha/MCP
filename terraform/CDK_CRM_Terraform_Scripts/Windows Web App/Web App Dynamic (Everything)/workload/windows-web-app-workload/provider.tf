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
  subscription_id = "41ae3075-2ae0-4d8a-8233-c602b5f8ef28"
}