// variables.tf
// This file defines the input variables for the azurerm_application_insights module.

variable "application_insights_name" {
  type        = string
  description = " (Required) Specifies the name of the Application Insights component."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Windows Web App should exist."
}

variable "location" {
  type        = string
  description = "The Azure Region where the Windows Web App should exist."
}

variable "workspace_id" {
  type        = string
  description = "(Optional) Specifies the id of a log analytics workspace resource."
}

variable "application_type" {
  type        = string
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure."

  validation {
    condition     = contains(["ios", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "web"], var.application_type)
    error_message = "The application_type must be one of 'ios', 'java', 'MobileCenter', 'Node.JS', 'other', 'phone', 'store', or 'web'."
  }
}

variable "retention_in_days" {
  type        = number
  description = "(Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = null
}
