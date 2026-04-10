// variables.tf
// This file defines the input variables for the azurerm_resource_group module.

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "tags" {
  type        = map(string)
  description = "tags for resource group"
}