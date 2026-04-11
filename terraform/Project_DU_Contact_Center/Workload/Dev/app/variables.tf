# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

# Variable for the Business unit name
variable "bu_name" {
  type        = string
  description = "The name of the Business unit."
}

# The geographical location where the resource group will be deployed.
variable "location" {
  type        = string
  description = "Location of the resource group."
}

#Variable to define tags for logic app
variable "tags" {
  type        = map(string)
  description = "Tags for logic app"
}

#Variable to define name of log analytics workspace
variable "law_name" {
  type        = string
  description = "Name of log analytics workspace"
}

#Variable to define rg name of log analytics workspace
variable "law_rg_name" {
  type        = string
  description = "Name of rg of log analytics workspace"
}