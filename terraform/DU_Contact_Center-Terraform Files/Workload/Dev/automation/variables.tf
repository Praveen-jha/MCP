# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
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

# The geographical location where the resources will be deployed.
variable "location" {
  type        = string
  description = "Location of the resources."
}

# Variable to define tags
variable "tags" {
  type        = map(string)
  description = "A map of common tags to assign resources."
}

# Variable to define Compute Workload RG name
variable "computeworkload_rg_name" {
  type = string
}


