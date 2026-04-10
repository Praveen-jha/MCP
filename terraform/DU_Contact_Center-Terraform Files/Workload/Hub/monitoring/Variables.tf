# Variable to define monitor resource group location
variable "monitor_resource_group_location" {
  type        = string
  description = "Location of monitor resource group"
}

# Variable to define retention days of log analytics workspace
variable "law_retention_days" {
  type        = number
  description = "Number of retention days for log analytics workspace"
}

# Variable to define tenant name of the log analytics workspace
variable "tenant_name" {
  type        = string
  description = "Tenant name"
}

# Variable to define environment of the log analytics workspace
variable "environment" {
  type        = string
  description = "Name of the environment"
}

# Variable to define tags for the log analytics workspace
variable "law_tags" {
  type        = map(string)
  description = "A map of tags to assign to the log analytics workspace"
}
variable "rg_creation" {
  description = "Resource Creation"
  type        = string
}
variable "workload_type" {
  description = "workload type of the resource"
  type        = string
}
variable "location_shortname" {
  description = "Location shortname"
  type        = string
}
variable "resource_group_tags" {
  description = "resource group tags"
  type        = map(string)
}
 