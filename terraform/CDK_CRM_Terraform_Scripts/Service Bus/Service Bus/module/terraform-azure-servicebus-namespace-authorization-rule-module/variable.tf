#variables.tf
# Variables for configuring a Service Bus Namespace Authorization Rule with role-based access settings.

variable "namespace_authorization_rule_name" {
  description = "Specifies the name of the ServiceBus Namespace Authorization Rule resource."
  type        = string
}

variable "servicebus_namespace_id" {
  description = "Specifies the ID of the ServiceBus Namespace."
  type        = string
}

variable "listen" {
  description = "Grants listen access to this Authorization Rule. Defaults to false."
  type        = bool
  default     = false
}

variable "send" {
  description = "Grants send access to this Authorization Rule. Defaults to false."
  type        = bool
  default     = false
}

variable "manage" {
  description = "Grants manage access to this Authorization Rule. When true, both listen and send must be too. Defaults to false."
  type        = bool
  default     = false
}
