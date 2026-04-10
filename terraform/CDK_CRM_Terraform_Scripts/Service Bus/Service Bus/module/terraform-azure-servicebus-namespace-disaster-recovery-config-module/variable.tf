#variables.tf
# Defines variables required to configure Service Bus Geo-Disaster Recovery between primary and secondary namespaces.

variable "name" {
  description = "The name of the Disaster Recovery Config (alias name)."
  type        = string
}

variable "primary_namespace_id" {
  description = "The ID of the primary Service Bus Namespace."
  type        = string
}

variable "partner_namespace_id" {
  description = "The ID of the secondary (partner) Service Bus Namespace."
  type        = string
}

variable "alias_authorization_rule_id" {
  description = "The ID of the shared access authorization rule to access the alias."
  type        = string
  default     = null
}
