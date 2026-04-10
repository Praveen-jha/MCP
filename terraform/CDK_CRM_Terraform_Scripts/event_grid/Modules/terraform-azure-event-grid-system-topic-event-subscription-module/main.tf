# Create EventGrid System Topic Event Subscription
resource "azurerm_eventgrid_system_topic_event_subscription" "this" {
  name                = var.name
  system_topic        = var.system_topic
  resource_group_name = var.resource_group_name

  # Only set event_delivery_schema if it's not null
  event_delivery_schema = var.event_delivery_schema != null ? var.event_delivery_schema : "EventGridSchema"
  expiration_time_utc   = var.expiration_time
  included_event_types  = var.included_event_types
  labels                = var.labels

  # Subject filter
  dynamic "subject_filter" {
    for_each = var.subject_filter != null ? [var.subject_filter] : []
    content {
      subject_begins_with = subject_filter.value.subject_begins_with
      subject_ends_with   = subject_filter.value.subject_ends_with
      case_sensitive      = subject_filter.value.case_sensitive
    }
  }

  # Advanced filters
  dynamic "advanced_filter" {
    for_each = var.advanced_filters != null ? [var.advanced_filters] : []
    content {
      # String filters
      dynamic "string_begins_with" {
        for_each = lookup(advanced_filter.value, "string_begins_with", [])
        content {
          key    = string_begins_with.value.key
          values = string_begins_with.value.values
        }
      }

      dynamic "string_contains" {
        for_each = lookup(advanced_filter.value, "string_contains", [])
        content {
          key    = string_contains.value.key
          values = string_contains.value.values
        }
      }

      dynamic "string_ends_with" {
        for_each = lookup(advanced_filter.value, "string_ends_with", [])
        content {
          key    = string_ends_with.value.key
          values = string_ends_with.value.values
        }
      }

      dynamic "string_in" {
        for_each = lookup(advanced_filter.value, "string_in", [])
        content {
          key    = string_in.value.key
          values = string_in.value.values
        }
      }

      dynamic "string_not_in" {
        for_each = lookup(advanced_filter.value, "string_not_in", [])
        content {
          key    = string_not_in.value.key
          values = string_not_in.value.values
        }
      }

      # Number filters
      dynamic "number_greater_than" {
        for_each = lookup(advanced_filter.value, "number_greater_than", [])
        content {
          key   = number_greater_than.value.key
          value = number_greater_than.value.value
        }
      }

      dynamic "number_less_than" {
        for_each = lookup(advanced_filter.value, "number_less_than", [])
        content {
          key   = number_less_than.value.key
          value = number_less_than.value.value
        }
      }

      dynamic "number_in" {
        for_each = lookup(advanced_filter.value, "number_in", [])
        content {
          key    = number_in.value.key
          values = number_in.value.values
        }
      }

      # Boolean filters
      dynamic "bool_equals" {
        for_each = lookup(advanced_filter.value, "bool_equals", [])
        content {
          key   = bool_equals.value.key
          value = bool_equals.value.value
        }
      }
    }
  }

  # Retry policy
  dynamic "retry_policy" {
    for_each = var.retry_policy != null ? [var.retry_policy] : []
    content {
      max_delivery_attempts = retry_policy.value.max_delivery_attempts
      event_time_to_live    = retry_policy.value.event_time_to_live
    }
  }

  # Dead letter identity
  dynamic "dead_letter_identity" {
    for_each = var.dead_letter_identity != null ? [var.dead_letter_identity] : []
    content {
      type                   = dead_letter_identity.value.type
      user_assigned_identity = dead_letter_identity.value.user_assigned_identity
    }
  }

  # Delivery identity
  dynamic "delivery_identity" {
    for_each = var.delivery_identity != null ? [var.delivery_identity] : []
    content {
      type                   = delivery_identity.value.type
      user_assigned_identity = delivery_identity.value.user_assigned_identity
    }
  }

  # Endpoint configurations (mutually exclusive)
  # Storage Queue Endpoint
  dynamic "storage_queue_endpoint" {
    for_each = var.storage_queue_endpoint != null ? [var.storage_queue_endpoint] : []
    content {
      storage_account_id = storage_queue_endpoint.value.storage_account_id
      queue_name         = storage_queue_endpoint.value.queue_name
    }
  }

  # Storage Blob Dead Letter Destination
  dynamic "storage_blob_dead_letter_destination" {
    for_each = var.storage_blob_dead_letter_destination != null ? [var.storage_blob_dead_letter_destination] : []
    content {
      storage_account_id          = storage_blob_dead_letter_destination.value.storage_account_id
      storage_blob_container_name = storage_blob_dead_letter_destination.value.storage_blob_container_name
    }
  }

  # Service Bus Queue Endpoint
  service_bus_queue_endpoint_id = var.service_bus_queue_endpoint_id

  # Service Bus Topic Endpoint  
  service_bus_topic_endpoint_id = var.service_bus_topic_endpoint_id

  # Event Hub Endpoint
  eventhub_endpoint_id = var.eventhub_endpoint_id

  # Hybrid Connection Endpoint
  hybrid_connection_endpoint_id = var.hybrid_connection_endpoint_id

  # Azure Function Endpoint
  dynamic "azure_function_endpoint" {
    for_each = var.azure_function_endpoint != null ? [var.azure_function_endpoint] : []
    content {
      function_id                       = azure_function_endpoint.value.function_id
      max_events_per_batch              = azure_function_endpoint.value.max_events_per_batch
      preferred_batch_size_in_kilobytes = azure_function_endpoint.value.preferred_batch_size_in_kilobytes
    }
  }

  # WebHook Endpoint
  dynamic "webhook_endpoint" {
    for_each = var.webhook_endpoint != null ? [var.webhook_endpoint] : []
    content {
      url                               = webhook_endpoint.value.url
      base_url                          = webhook_endpoint.value.base_url
      max_events_per_batch              = webhook_endpoint.value.max_events_per_batch
      preferred_batch_size_in_kilobytes = webhook_endpoint.value.preferred_batch_size_in_kilobytes
      active_directory_tenant_id        = webhook_endpoint.value.active_directory_tenant_id
      active_directory_app_id_or_uri    = webhook_endpoint.value.active_directory_app_id_or_uri
    }
  }
}
