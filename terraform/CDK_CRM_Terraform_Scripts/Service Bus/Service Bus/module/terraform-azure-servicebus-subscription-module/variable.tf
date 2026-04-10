#variables.tf
# Defines variables for configuring an Azure Service Bus Subscription, including TTLs, session settings, dead-lettering options, forwarding, and client-scoped settings.

variable "name" {
  description = "Name of the ServiceBus Subscription"
  type        = string
}

variable "topic_id" {
  description = "ID of the ServiceBus Topic this Subscription belongs to"
  type        = string
}

variable "max_delivery_count" {
  description = "Maximum delivery count before dead-lettering the message"
  type        = number
}

variable "auto_delete_on_idle" {
  description = "Idle time before the subscription is automatically deleted"
  type        = string
  default     = null
}

variable "default_message_ttl" {
  description = "Default time-to-live for messages"
  type        = string
  default     = null
}

variable "lock_duration" {
  description = "Duration of message lock"
  type        = string
  default     = null
}

variable "dead_lettering_on_message_expiration" {
  description = "Enable dead-lettering when a message expires"
  type        = bool
  default     = null
}

variable "dead_lettering_on_filter_evaluation_error" {
  description = "Enable dead-lettering on filter evaluation errors"
  type        = bool
  default     = null
}

variable "batched_operations_enabled" {
  description = "Whether batched operations are enabled"
  type        = bool
  default     = null
}

variable "requires_session" {
  description = "Whether the subscription requires sessions"
  type        = bool
  default     = null
}

variable "forward_to" {
  description = "Name of Queue or Topic to forward messages to"
  type        = string
  default     = null
}

variable "forward_dead_lettered_messages_to" {
  description = "Queue or Topic to forward dead-lettered messages to"
  type        = string
  default     = null
}

variable "status" {
  description = "Status of the Subscription (Active, ReceiveDisabled, or Disabled)"
  type        = string
  default     = null
}

variable "client_scoped_subscription_enabled" {
  description = "Enable client-scoped subscription"
  type        = bool
  default     = false
}

variable "client_scoped_subscription" {
  description = "Client scoped subscription block"
  type = object({
    client_id                               = optional(string)
    is_shareable                            = optional(bool)
    is_durable                              = optional(bool)
  })
  default = null
}
