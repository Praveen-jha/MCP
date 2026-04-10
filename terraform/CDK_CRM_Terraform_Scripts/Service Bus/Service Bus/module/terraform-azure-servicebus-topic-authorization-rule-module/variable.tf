#Variables.tf
# Defines input variables for configuring a Service Bus Topic Authorization Rule in Azure.
variable "auth_rule_name" {
  type        = string
  description = "Specifies the name of the ServiceBus Topic Authorization Rule resource.\nRegistry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic_authorization_rule"
  validation {
    condition     = length(var.auth_rule_name) > 0
    error_message = "The name must not be empty."
  }
}

variable "topic_id" {
  type        = string
  description = "Specifies the ID of the ServiceBus Topic."
  validation {
    condition     = can(regex("^/subscriptions/", var.topic_id))
    error_message = "The topic_id must be a valid Azure Resource ID."
  }
}

variable "listen" {
  type        = bool
  default     = false
  description = "Grants listen access to this Authorization Rule."
}

variable "send" {
  type        = bool
  default     = false
  description = "Grants send access to this Authorization Rule."
}

variable "manage" {
  type        = bool
  default     = false
  description = "Grants manage access to this Authorization Rule. If set to true, both 'listen' and 'send' must be true."
  validation {
    condition     = var.manage == false || (var.listen == true && var.send == true)
    error_message = "If 'manage' is true, both 'listen' and 'send' must also be true."
  }
}
