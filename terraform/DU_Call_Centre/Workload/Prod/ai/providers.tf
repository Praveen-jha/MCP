terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.18.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~>2.0.1"
    }

  }
}

provider "azurerm" {
  features {}
  subscription_id = "b092ed20-9480-45e1-a96c-8b307bfa9eab"
}

provider "azurerm" {
  alias           = "hub"
  subscription_id = "0207aa1d-1c80-483b-9e70-960963c72cda"
  features {
  }
}

 
