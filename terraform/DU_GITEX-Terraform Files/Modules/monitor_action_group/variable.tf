variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the action group will be created."
}

variable "action_group_name" {
  type        = string
  description = "The name of the action group to be created in Azure Monitor."
}

variable "action_group_shortname" {
  type        = string
  description = "A short name for the action group, used in Azure Monitor for easier identification."
}

variable "email_receivers" {
  type = list(object({
    name          = string
    email_address = string
  }))
  description = "A list of email receivers for the action group. Each receiver must have a name and an email address."
}

