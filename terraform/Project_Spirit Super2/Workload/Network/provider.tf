terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.97.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  # client_id = "91acc948-d779-4643-a2de-3c7b34e47992"
  # client_secret = "q9V8Q~.sRq1JOq9z.LLztNkSwJuGodFcVPklTaRt"
  subscription_id = "a746bef1-0f80-4ee5-888c-d0ff7d17f254"   
  tenant_id = "f2af2d03-ec7d-4deb-8b98-90e91aedfe71"
}