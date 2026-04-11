terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.97.0"
    }
  }
  //backend "azurerm" { }
}

provider "azurerm" {
  features {
  }
  client_id       = "f917efc4-e7ab-434c-a91f-4fb02083a60e"
  client_secret   = "Giq8Q~b6Emw1D1oNxh~mkf47uIadi1NJUyxe1bV4"
  subscription_id = "41ae3075-2ae0-4d8a-8233-c602b5f8ef28"
  tenant_id       = "d18895cc-999c-43f0-acda-6b008393110a"
}
