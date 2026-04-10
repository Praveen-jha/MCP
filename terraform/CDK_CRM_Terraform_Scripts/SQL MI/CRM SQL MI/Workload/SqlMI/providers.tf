terraform {
  # required_version = "1.9.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.28.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = "3a602f8c-a0de-4cb1-a83a-267b7d75ac0e"
  client_id                       = "91e4856e-a472-47d7-b681-be9c345cf988"
  client_secret                   = "m1i8Q~LBkVgrdCRyFw-cWh751xxXDMy1koEwLbai"
  tenant_id                       = "70a6077f-acae-4fbc-b7bc-429cb1aa511d"
}

provider "azuread" {
  client_id     = "91e4856e-a472-47d7-b681-be9c345cf988"
  client_secret = "m1i8Q~LBkVgrdCRyFw-cWh751xxXDMy1koEwLbai"
  tenant_id     = "70a6077f-acae-4fbc-b7bc-429cb1aa511d"
}

provider "azurerm" {
  alias                           = "hub"
  resource_provider_registrations = "none"
  subscription_id                 = "3a602f8c-a0de-4cb1-a83a-267b7d75ac0e"
  tenant_id                       = "70a6077f-acae-4fbc-b7bc-429cb1aa511d"
  client_id                       = "155c31d9-63a7-4090-8ec4-5058593dcfae"
  client_secret                   = "cA08Q~lxYQKhcNHQUkm3d0dINzFkqyeKwRMOgcVi"
  features {
  }
}