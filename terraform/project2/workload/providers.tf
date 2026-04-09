terraform {
  required_version = ">= 1.4.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.21.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  # Configuration options
  # skip_provider_registration = true
  features {
    key_vault {
      recover_soft_deleted_keys       = true
      recover_soft_deleted_key_vaults = true
    }
  }
  resource_provider_registrations = "none"
  storage_use_azuread             = true
  use_oidc                        = true
}
