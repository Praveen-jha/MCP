#Variables for Monitor Action Group module main file
variable "resource_group_name" {
  description = "The name of the Azure Resource Group where resources are located."
  type        = string
}

variable "action_group_name" {
  description = "Name of the Azure Monitor Action Group."
  type        = string
}

variable "action_group_short_name" {
  description = "Short name for the Action Group."
  type        = string
}

# Dynamic Email Receiver List
variable "email_details" { 
  description = "A map of email receivers for the action group."
  type        = map(string)
}