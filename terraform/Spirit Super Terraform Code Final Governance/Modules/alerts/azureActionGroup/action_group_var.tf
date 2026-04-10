variable "action_group_name" {
  type        = string
  description = "(Required) The name of the Action Group."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Action Group instance."
}

variable "action_group_short_name" {
  type        = string
  description = "(Required) The short name of the action group. This will be used in SMS messages."
}

variable "email_receiver" {
  type = map(object({
    name          = string
    email_address = string
  }))
  description = "(Optional) One or more email_receiver blocks having name and email address of the receiver."
}
