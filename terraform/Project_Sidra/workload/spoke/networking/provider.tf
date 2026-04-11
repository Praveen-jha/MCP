terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
  backend "azurerm" {

  }
}
provider "azurerm" {
  features {
  }
  subscription_id                 = "362a704f-feab-4b96-b92a-ea7bbf72fed9"
  resource_provider_registrations = "none"
}