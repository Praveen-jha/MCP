terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.97.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "storage-rg-01"
  #   storage_account_name = "statefilestorageacc01"
  #   container_name       = "state-file"
  #   key                  = "terraform.tfstate"
  #   subscription_id      = "de9f4996-a1cd-4ddc-b28c-7331aa0f0d14"
  #   tenant_id            = "fbfc68c0-7c02-425d-af28-7b6a4750818d"
  #   access_key           = "uuR3Crl0M0VuTIyTdarx4nU7B5gVDi4f6MSihPqWn+qhzog7pRkxbiMpBFs318zf2J9pswsHJzwF+AStBm1mrw=="
  # }
}

provider "azurerm" {
  features {
  }
  # client_id = "f917efc4-e7ab-434c-a91f-4fb02083a60e"
  # client_secret = "TlZ8Q~-.HNESUCgX.hqERkPAD3UFJSYanRFGfct-"
  subscription_id = "a746bef1-0f80-4ee5-888c-d0ff7d17f254"   
  tenant_id = "f2af2d03-ec7d-4deb-8b98-90e91aedfe71"
}