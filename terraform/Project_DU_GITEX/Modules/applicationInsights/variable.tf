variable "name" {
  description = "Name of Application insights"
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location for the Application insights"
  type        = string
}

variable "application_type" {
  description = "Type of Application"
  type = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type = string
}