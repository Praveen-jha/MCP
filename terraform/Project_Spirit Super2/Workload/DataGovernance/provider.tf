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
  subscription_id = "41ae3075-2ae0-4d8a-8233-c602b5f8ef28" 
  tenant_id = "d18895cc-999c-43f0-acda-6b008393110a"
}
