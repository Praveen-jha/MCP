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

#Variable for Fabric Capacity
variable "fabric_capacity" {
  type = object({
    fabric_capacity_administration_members = list(string) //An array of administrator user identities. The member must be an Entra member user or a service principal
    fabric_capacity_sku                    = string //The name of the SKU to use for the Fabric Capacity. Possible values are F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048
  })
}

//The public_network_access_enabled variable controls weather public access is allowed on all the PaaS services or not.
variable "public_network_access_enabled" {
  description = "is public network access enabled on the PaaS resources? Defaults to False if no value is passed."
  type        = bool
  default     = false
}
