variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "resource_group_tags" {
  type        = map(string)
  description = "Tags of the resource group."
}