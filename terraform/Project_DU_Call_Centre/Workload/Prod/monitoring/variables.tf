#Variable to define location of monitor resource group
variable "location" {
  type        = string
  description = "Location of monitor resource group"
}

#Variable to define retention days of log analytics workspace
variable "law_retention_days" {
  type        = number
  description = "Number of retention days for log analytics workspace"
}

#Variable to define tenant name of log analytics workspace
variable "tenant_name" {
  type        = string
  description = "Tenant name"
}

#Variable to define BU name of log analytics workspace
variable "bu_name" {
  type        = string
  description = "Business unit name"
}

# Variable to define tags for the log analytics workspace
variable "law_tags" {
  type        = map(string)
  description = "A map of tags to assign to the log analytics workspace."
}