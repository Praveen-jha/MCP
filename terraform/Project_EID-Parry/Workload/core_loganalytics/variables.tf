# Variables for Hub Network Workload
variable "nameConfig" {
  type = object({
    defaultLocation = string      //Location for the Resource to be Deployed.
    tags            = map(string) //"Tags are key-value pairs that help organize and manage resources by categorizing them (e.g., by environment, department, or purpose)."
    rg_creation     = string      //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    environment     = string      //Deployment Environment (for example UAT or Prod).
    businessunit    = string      //Workload type of the resource
    identity        = string      //Flag to use in Naming Convention
  })
}

variable "log_analytics_workspace" {
  type = object({
    sku               = string //The SKU (pricing tier) for the Log Analytics Workspace.
    retention_in_days = number //The retention is days for auditing, diagnostic and metric logs per your organizations requirements. Default = 180 days
  })
}
