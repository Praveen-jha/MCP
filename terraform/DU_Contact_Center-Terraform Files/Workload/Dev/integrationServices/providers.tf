terraform {
  required_version = "1.11.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.2.0"
    }
    fabric = {
      source  = "microsoft/fabric"
      version = "0.1.0-beta.4"
    }
  }
}

provider "azurerm" {
  features {}
}

# provider "azapi" {
#   subscription_id = "17f94bdc-8e26-45b1-9650-fb88217dd273"
# }

provider "fabric" {
}