terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.97.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "testRG-01"
    storage_account_name = "spiritsuperpoctestst01"
    container_name       = "sha-vm-deployment"
    key                  = "sha-vm-deployment.tfstate"
    subscription_id      = "41ae3075-2ae0-4d8a-8233-c602b5f8ef28"
    tenant_id            = "d18895cc-999c-43f0-acda-6b008393110a"
    access_key           = "dGnnAMHCa8E8zKerjUHCMzqsXLrwU/Y8ivOnRpKAAzvh521DjkctN52nhKa6k3o8rKJoOp8L4tH0+AStpGnTmA=="
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "41ae3075-2ae0-4d8a-8233-c602b5f8ef28"   
  tenant_id = "d18895cc-999c-43f0-acda-6b008393110a"
}