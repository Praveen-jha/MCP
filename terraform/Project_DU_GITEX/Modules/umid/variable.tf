variable "location" {
  description = "(Required) The Azure Region where the User Assigned Identity should exist."
  type        = string
}

variable "umid_name" {
  description = "(Required) Specifies the name of this User Assigned Identity."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist."
  type        = string
}
