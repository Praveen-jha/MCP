#Variables for Resource Group Budget module main file

variable "budget_name" {
  description = "The name of the Consumption Budget for the Resource Group."
  type        = string
}

variable "budget_resource_group_id" {
  description = "The ID of the Azure Resource Group this budget applies to."
  type        = string
}

variable "budget_amount" {
  description = "The total amount of cost to track for the budget."
  type        = number
}

variable "budget_time_grain" {
  description = "The time grain for the budget. Possible values are 'Annually', 'Monthly', and 'Quarterly'."
  type        = string
}

variable "budget_start_date" {
  description = "The start date for the budget in 'YYYY-MM-DDTHH:MM:SSZ' format."
  type        = string
}

variable "budget_end_date" {
  description = "The end date for the budget in 'YYYY-MM-DDTHH:MM:SSZ' format. Optional."
  type        = string
  default     = null
}

variable "budget_notifications" {
  description = "A list of notification configurations for the budget."
  type = list(object({
    enabled        = bool                       # Whether the notification is enabled
    threshold      = number                     # The threshold percentage for the notification (e.g., 90.0)
    operator       = string                     # The operator for the threshold ('EqualTo', 'GreaterThan', 'GreaterThanOrEqualTo')
    threshold_type = optional(string)           # Optional: 'Actual' or 'Forecasted'. Defaults to 'Actual' if not specified by Azure.
    contact_emails = optional(list(string), []) # List of email addresses to notify
    contact_roles  = optional(list(string), []) # List of Azure RBAC roles to notify (e.g., 'Owner', 'Contributor')
  }))
  default = [] # Default to an empty list if no notifications are needed
}

variable "contact_groups" {
  type        = list(string)
  description = "List of Action Group IDs to notify"
}
