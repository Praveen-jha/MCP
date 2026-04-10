#variables.tf
# Defines inputs and validation for configuring an Azure Service Bus Queue Authorization Rule.

variable "authorization_rule_name" {
  description = "(Required) Name of the Service Bus Queue Authorization Rule."
  type        = string
  validation {
    condition     = length(var.authorization_rule_name) > 2
    error_message = "The authorization rule name must be at least 3 characters long."
  }
}

variable "queue_id" {
  description = "(Required) The ID of the Service Bus Queue."
  type        = string
  validation {
    condition     = can(regex("^/subscriptions/.+/resourceGroups/.+/providers/Microsoft.ServiceBus/namespaces/.+/queues/.+", var.queue_id))
    error_message = "The queue_id must be a valid Service Bus Queue ID."
  }
}

variable "listen" {
  description = "(Optional) Listen permission for the Authorization Rule."
  type        = bool
  default     = false
}

variable "send" {
  description = "(Optional) Send permission for the Authorization Rule."
  type        = bool
  default     = false
}

variable "manage" {
  description = "(Optional) Manage permission for the Authorization Rule. If true, both listen and send must also be true."
  type        = bool
  default     = false
  validation {
    condition     = var.manage == false || (var.listen == true && var.send == true)
    error_message = "If 'manage' is true, both 'listen' and 'send' must also be true."
  }
}
