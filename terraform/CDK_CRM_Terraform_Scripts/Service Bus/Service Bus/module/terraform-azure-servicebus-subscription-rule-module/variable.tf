#variables.tf
# Declares input variables for creating a Service Bus Subscription Rule, supporting both SQL and Correlation filters.

variable "name" {
  description = "Name of the ServiceBus Subscription Rule"
  type        = string
}

variable "subscription_id" {
  description = "ID of the ServiceBus Subscription where this rule is applied"
  type        = string
}

variable "filter_type" {
  description = "Type of the filter: SqlFilter or CorrelationFilter"
  type        = string
  validation {
    condition     = contains(["SqlFilter", "CorrelationFilter"], var.filter_type)
    error_message = "filter_type must be either 'SqlFilter' or 'CorrelationFilter'."
  }
}

variable "sql_filter" {
  description = "SQL filter condition to evaluate BrokeredMessage (for SqlFilter type)"
  type        = string
  default     = null
}

variable "action" {
  description = "SQL-based action to perform on BrokeredMessage"
  type        = string
  default     = null
}

variable "correlation_filter" {
  description = "Correlation filter block (required if filter_type = CorrelationFilter)"
  type = object({
    content_type        = optional(string)
    correlation_id      = optional(string)
    label               = optional(string)
    message_id          = optional(string)
    reply_to            = optional(string)
    reply_to_session_id = optional(string)
    session_id          = optional(string)
    to                  = optional(string)
    properties          = optional(map(string))
  })
}

variable "name" {
  type        = string
  description = "Specifies the name of the ServiceBus Subscription Rule. Changing this forces a new resource to be created.\nRegistry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule"
  validation {
    condition     = length(var.name) > 0
    error_message = "The name must not be empty."
  }
}

variable "subscription_id" {
  type        = string
  description = "The ID of the ServiceBus Subscription in which this Rule should be created. Changing this forces a new resource to be created."
  validation {
    condition     = can(regex("^/subscriptions/", var.subscription_id))
    error_message = "The subscription_id must be a valid Azure Resource ID."
  }
}

variable "filter_type" {
  type        = string
  description = "Type of filter to be applied to a BrokeredMessage. Possible values: SqlFilter, CorrelationFilter."
  validation {
    condition     = contains(["SqlFilter", "CorrelationFilter"], var.filter_type)
    error_message = "filter_type must be either 'SqlFilter' or 'CorrelationFilter'."
  }
}

variable "sql_filter" {
  type        = string
  default     = null
  description = "SQL filter expression to evaluate against a BrokeredMessage. Required when filter_type is SqlFilter."
}

variable "correlation_filter" {
  type = object({
    content_type        = optional(string)
    correlation_id      = optional(string)
    label               = optional(string)
    message_id          = optional(string)
    reply_to            = optional(string)
    reply_to_session_id = optional(string)
    session_id          = optional(string)
    to                  = optional(string)
    properties          = optional(map(string))
  })
  default     = null
  description = "Correlation filter block. Required when filter_type is CorrelationFilter."
}

variable "action" {
  type        = string
  default     = null
  description = "SQL-like action expression that is performed against a BrokeredMessage."
}
 