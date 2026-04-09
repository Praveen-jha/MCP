variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for the resource group"
  type        = string
}

variable "identity_name" {
  description = "The name of the user-assigned identity"
  type        = string
}

variable "tags" {
  description = "The tags required for the resource"
  type        = map(string)
}
