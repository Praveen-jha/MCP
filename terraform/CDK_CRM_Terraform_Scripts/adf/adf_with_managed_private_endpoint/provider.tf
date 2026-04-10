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
  subscription_id = "99705b85-b557-494c-bc4b-73e0ca27df77"
}
