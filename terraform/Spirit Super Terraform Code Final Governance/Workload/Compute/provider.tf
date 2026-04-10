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
  # client_id = "91acc948-d779-4643-a2de-3c7b34e47992"
  # client_secret = "q9V8Q~.sRq1JOq9z.LLztNkSwJuGodFcVPklTaRt"
  subscription_id = "397c98c6-bfe4-461d-b8a4-e77778e6805b"   
  tenant_id = "e4e34038-ea1f-4882-b6e8-ccd776459ca0"
}