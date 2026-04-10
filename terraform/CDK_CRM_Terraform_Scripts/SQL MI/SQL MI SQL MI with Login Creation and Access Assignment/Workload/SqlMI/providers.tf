# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.22.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
  subscription_id = ""
}

provider "azuread" {
  tenant_id     = ""
  client_id     = ""
  client_secret = ""
}