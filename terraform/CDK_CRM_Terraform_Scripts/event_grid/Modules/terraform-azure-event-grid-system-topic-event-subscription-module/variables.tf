variable "name" {
  description = "The name of the EventGrid System Topic Event Subscription"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$", var.name))
    error_message = "Event subscription name must be 3-64 characters long, start and end with alphanumeric characters, and can contain hyphens."
  }
}

variable "system_topic" {
  description = "The name of the System Topic where this Event Subscription should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the System Topic exists"
  type        = string
}

variable "event_delivery_schema" {
  description = "Event delivery schema"
  type        = string
  default     = null
  validation {
    condition = var.event_delivery_schema == null || contains([
      "EventGridSchema",
      "CloudEventSchemaV1_0",
      "CustomInputSchema"
    ], var.event_delivery_schema)
    error_message = "Event delivery schema must be one of: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema."
  }
}

variable "advanced_filtering_on_arrays_enabled" {
  description = "Whether advanced filtering on arrays is enabled"
  type        = bool
  default     = false
}

variable "expiration_time" {
  description = "The expiration time of the event subscription in RFC 3339 format"
  type        = string
  default     = null
}

variable "included_event_types" {
  description = "A list of applicable event types that need to be part of the event subscription"
  type        = list(string)
  default     = null
}

variable "labels" {
  description = "A list of labels to assign to the event subscription"
  type        = list(string)
  default     = null
}

variable "subject_filter" {
  description = "Subject filter configuration"
  type = object({
    subject_begins_with = optional(string)
    subject_ends_with   = optional(string)
    case_sensitive      = optional(bool, false)
  })
  default = null
}

variable "advanced_filters" {
  description = "Advanced filter configuration"
  type = object({
    string_begins_with = optional(list(object({
      key    = string
      values = list(string)
    })), [])
    string_contains = optional(list(object({
      key    = string
      values = list(string)
    })), [])
    string_ends_with = optional(list(object({
      key    = string
      values = list(string)
    })), [])
    string_in = optional(list(object({
      key    = string
      values = list(string)
    })), [])
    string_not_in = optional(list(object({
      key    = string
      values = list(string)
    })), [])
    number_greater_than = optional(list(object({
      key   = string
      value = number
    })), [])
    number_less_than = optional(list(object({
      key   = string
      value = number
    })), [])
    number_in = optional(list(object({
      key    = string
      values = list(number)
    })), [])
    bool_equals = optional(list(object({
      key   = string
      value = bool
    })), [])
  })
  default = null
}

variable "retry_policy" {
  description = "Retry policy configuration"
  type = object({
    max_delivery_attempts = number
    event_time_to_live    = number
  })
  default = null
}

variable "dead_letter_identity" {
  description = "Dead letter identity configuration"
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

variable "delivery_identity" {
  description = "Delivery identity configuration"
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

# Endpoint configurations (mutually exclusive)
variable "storage_queue_endpoint" {
  description = "Storage Queue endpoint configuration"
  type = object({
    storage_account_id = string
    queue_name         = string
  })
  default = null
}

variable "storage_blob_dead_letter_destination" {
  description = "Storage Blob dead letter destination configuration"
  type = object({
    storage_account_id          = string
    storage_blob_container_name = string
  })
  default = null
}

variable "service_bus_queue_endpoint_id" {
  description = "The ID of the Service Bus Queue to receive events"
  type        = string
  default     = null
}

variable "service_bus_topic_endpoint_id" {
  description = "The ID of the Service Bus Topic to receive events"
  type        = string
  default     = null
}

variable "eventhub_endpoint_id" {
  description = "The ID of the Event Hub to receive events"
  type        = string
  default     = null
}

variable "hybrid_connection_endpoint_id" {
  description = "The ID of the Hybrid Connection to receive events"
  type        = string
  default     = null
}

variable "azure_function_endpoint" {
  description = "Azure Function endpoint configuration"
  type = object({
    function_id                       = string
    max_events_per_batch             = optional(number)
    preferred_batch_size_in_kilobytes = optional(number)
  })
  default = null
}

variable "webhook_endpoint" {
  description = "WebHook endpoint configuration"
  type = object({
    url                               = string
    base_url                          = optional(string)
    max_events_per_batch             = optional(number)
    preferred_batch_size_in_kilobytes = optional(number)
    active_directory_tenant_id        = optional(string)
    active_directory_app_id_or_uri    = optional(string)
  })
  default = null
}
