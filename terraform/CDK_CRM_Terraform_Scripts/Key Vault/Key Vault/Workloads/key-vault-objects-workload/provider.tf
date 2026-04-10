# Define required providers for Azure and Databricks
terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.16"
    }
  }
}
provider "azurerm" {
  #Configuration options
  features {}
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
