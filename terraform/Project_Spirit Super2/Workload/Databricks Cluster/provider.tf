terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.97.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.49.1"
    }
  }
 // backend "azurerm" {}
}

provider "azurerm" {
  features {
  }
  subscription_id = "367722a2-667e-40e3-ba4b-1078993dddf3"
  tenant_id = "bf5fa81f-9831-46a2-8bbf-6ca4c9a9eb4c"
} 

provider "databricks" {
  azure_workspace_resource_id = data.azurerm_databricks_workspace.databricks.id
  host                        = data.azurerm_databricks_workspace.databricks.workspace_url
  token                       = "dapif34c357d0b76071f8e610e105dbb64e8"
  auth_type = "pat"
}