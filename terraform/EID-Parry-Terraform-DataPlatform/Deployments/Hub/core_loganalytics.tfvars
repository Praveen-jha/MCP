nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "existing"
  environment     = "hub"
  businessunit    = "ea"
  identity        = "eid"
  tags = {
    "Business Owner" = "EID"
    "Business Unit"  = "EA"
    "Environment"    = "Hub"
  }
}

log_analytics_workspace = {
    sku               = "PerGB2018"
    retention_in_days = 30
}
