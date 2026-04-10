// variables.tf
// This file defines the input variables for the azurerm_resource_group module.

variable "resource_group_location" {
  description = "(Required) Location of the resource group."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Name of the resource group."
  type        = string
}

variable "resource_group_managed_by" {
  description = "(Optional) Id of the resource/application that manages this resource group."
  type        = string
  default     = null
}

variable "resource_group_tags" {
  description = "(Optional) tags for resource group"
  type        = map(string)
}