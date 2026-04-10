# variables.tf
# Defines input variables for configuring an Azure Service Bus Queue with customizable message handling, forwarding, and performance settings.

variable "name" {
  description = "Name of the Service Bus Queue."
  type        = string
}

variable "namespace_id" {
  description = "The ID of the Service Bus Namespace."
  type        = string
}

variable "lock_duration" {
  description = "Peek-lock duration (ISO 8601 format). Max 5 minutes."
  type        = string
  default     = null
}

variable "max_message_size_in_kilobytes" {
  description = "Maximum size of a message in kilobytes. (Premium only)."
  type        = number
  default     = null
}

variable "max_size_in_megabytes" {
  description = "Size in megabytes allocated to the queue."
  type        = number
  default     = null
}

variable "requires_duplicate_detection" {
  description = "Enable duplicate detection."
  type        = bool
  default     = false
}

variable "requires_session" {
  description = "Enable sessions for ordered message handling."
  type        = bool
  default     = false
}

variable "default_message_ttl" {
  description = "Default message time to live (ISO 8601 duration)."
  type        = string
  default     = null
}

variable "dead_lettering_on_message_expiration" {
  description = "Enable dead lettering on message expiration."
  type        = bool
  default     = false
}

variable "duplicate_detection_history_time_window" {
  description = "Duplicate detection history time window (ISO 8601)."
  type        = string
  default     = null
}

variable "max_delivery_count" {
  description = "Number of deliveries before dead-lettering."
  type        = number
  default     = 10
}

variable "status" {
  description = "Status of the queue."
  type        = string
  default     = "Active"
  validation {
    condition     = contains(["Active", "Creating", "Deleting", "Disabled", "ReceiveDisabled", "Renaming", "SendDisabled", "Unknown"], var.status)
    error_message = "Invalid queue status."
  }
}

variable "batched_operations_enabled" {
  description = "Enable batched operations."
  type        = bool
  default     = true
}

variable "auto_delete_on_idle" {
  description = "Auto delete queue after idle time (ISO 8601 duration)."
  type        = string
  default     = null
}

variable "partitioning_enabled" {
  description = "Enable queue partitioning."
  type        = bool
  default     = false
}

variable "express_enabled" {
  description = "Enable express queue (NOT allowed in Premium)."
  type        = bool
  default     = false
}

variable "forward_to" {
  description = "Queue/Topic to forward messages to."
  type        = string
  default     = null
}

variable "forward_dead_lettered_messages_to" {
  description = "Queue/Topic to forward dead-lettered messages to."
  type        = string
  default     = null
}
