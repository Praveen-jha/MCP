terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "0.1.0-beta.4"
    }
  }
}

provider "fabric" {}

resource "fabric_workspace" "fabric_workspace" {
  display_name = var.workspace_name
}