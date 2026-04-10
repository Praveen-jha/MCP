terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.97.0"
    }
  }
  //backend "azurerm" {}
}

provider "azurerm" {
  features {
  }
  subscription_id = "397c98c6-bfe4-461d-b8a4-e77778e6805b"
  tenant_id       = "e4e34038-ea1f-4882-b6e8-ccd776459ca0"
}
