# Variables.tf
# Variables to configure an Azure Service Bus Topic with optional settings like TTL, partitioning, duplicate detection, and message size limits.

variable "name" {
  type        = string
  description = "Specifies the name of the ServiceBus Topic.\nRegistry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic"
  validation {
    condition     = length(var.name) > 0
    error_message = "Topic name cannot be empty."
  }
}

variable "namespace_id" {
  type        = string
  description = "The ID of the ServiceBus Namespace in which this Topic should be created."
  validation {
    condition     = can(regex("^/subscriptions/", var.namespace_id))
    error_message = "Must be a valid Azure Resource ID."
  }
}

variable "status" {
  type        = string
  default     = "Active"
  description = "Status of the Topic. Possible values: Active, Disabled."
  validation {
    condition     = contains(["Active", "Disabled"], var.status)
    error_message = "status must be either 'Active' or 'Disabled'."
  }
}

variable "auto_delete_on_idle" {
  type        = string
  default     = null
  description = "ISO 8601 duration for idle auto-deletion (min 5 mins)."
}

variable "default_message_ttl" {
  type        = string
  default     = null
  description = "ISO 8601 duration for default TTL."
}

variable "duplicate_detection_history_time_window" {
  type        = string
  default     = null
  description = "ISO 8601 duration for duplicate detection."
}

variable "batched_operations_enabled" {
  type        = bool
  default     = null
  description = "Enable batched operations on the topic."
}

variable "express_enabled" {
  type        = bool
  default     = null
  description = "Enable express topic to temporarily store message in memory."
}

variable "partitioning_enabled" {
  type        = bool
  default     = null
  description = "Enable partitioning across brokers."
}

variable "max_message_size_in_kilobytes" {
  type        = number
  default     = null
  description = "Max message size in kilobytes for Premium SKU."
}

variable "max_size_in_megabytes" {
  type        = number
  default     = null
  description = "Max topic size in megabytes."
}

variable "requires_duplicate_detection" {
  type        = bool
  default     = null
  description = "Whether duplicate detection is required."
}

variable "support_ordering" {
  type        = bool
  default     = null
  description = "Whether message ordering is supported."
}
