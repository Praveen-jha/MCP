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