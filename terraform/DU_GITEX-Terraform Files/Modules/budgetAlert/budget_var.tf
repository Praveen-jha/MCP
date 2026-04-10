variable "budgetName" {
  description = "The name of the budget resource."
  type        = string
}

variable "amount" {
  description = "The total budget amount for the subscription, in the chosen currency."
  type        = number
}

variable "timeGrain" {
  description = "The granularity of the budget. Possible values are 'Monthly', 'Quarterly', or 'Annually'."
  type        = string
}

variable "startDate" {
  description = "The start date for the budget in ISO 8601 format (e.g., 'YYYY-MM-DD')."
  type        = string
}

variable "endDate" {
  description = "The end date for the budget in ISO 8601 format (e.g., 'YYYY-MM-DD')."
  type        = string
}

variable "notification" {
  description = "A map of notifications for the budget."
  type = map(object({
    enabled        = bool
    operator       = string
    threshold      = number
    thresholdType  = string
    contact_emails = list(string)
  }))
}