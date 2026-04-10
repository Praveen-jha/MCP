terraform {
  required_version = "1.11.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.26.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "b092ed20-9480-45e1-a96c-8b307bfa9eab"
}
