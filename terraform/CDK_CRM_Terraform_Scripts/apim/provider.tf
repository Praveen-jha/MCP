#provider.tf
# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.21.1"
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Aliased provider for CNAME DNS items only
provider "azurerm" {
  alias           = "hub"
  subscription_id = var.hub_subscription_id
  features {}
}
