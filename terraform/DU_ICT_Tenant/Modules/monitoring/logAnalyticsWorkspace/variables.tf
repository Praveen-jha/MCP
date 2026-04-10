variable "log_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "log_location" {
  description = "Location of the Log Analytics workspace"
  type        = string
}

variable "log_resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "logAnalytics_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Virtual Network."
}

variable "log_retention_in_days" {
  description = "Retention period (in days) for data in the Log Analytics workspace"
  type        = number
}
