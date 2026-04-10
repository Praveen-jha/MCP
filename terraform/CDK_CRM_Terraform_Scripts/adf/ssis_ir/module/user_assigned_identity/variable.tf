# variable.tf
 # This file defines the variables for the User Assigned Identity module for Azure Data Factory credentials.
variable "name" {
  description = "The name of the Data Factory Credential User Managed Identity."
  type        = string
}

variable "data_factory_id" {
  description = "The ID of the Data Factory where the credential will be created."
  type        = string
}

variable "user_assigned_identity_id" {
  description = "The ID of the User Assigned Managed Identity to use for the credential."
  type        = string
}

variable "description" {
  description = "(Optional) A description for the credential."
  type        = string
  default     = null
}
