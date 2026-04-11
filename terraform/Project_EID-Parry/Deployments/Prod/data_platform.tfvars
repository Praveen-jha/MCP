nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "existing"
  environment     = "prd"
  businessunit    = "ea"
  identity        = "eid"
  tags = {
    "Business Owner" = "EID"
    "Business Unit"  = "EA"
    "Environment"    = "Prod"
  }
}

fabric_capacity = {
  fabric_capacity_administration_members = ["celebaltech10@naccess.onmicrosoft.com"]
  fabric_capacity_sku                    = "F8"
}

public_network_access_enabled = false
