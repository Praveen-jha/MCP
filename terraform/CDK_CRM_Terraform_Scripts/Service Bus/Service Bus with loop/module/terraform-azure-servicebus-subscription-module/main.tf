# -------------------------------------------------------------
# Module: Service Bus Subscription
# Registry Reference: https://registry.terraform.io/providers/hashicorp/azurerm/4.4.0/docs/resources/servicebus_subscription_rule.html
# Description: Manages a Service Bus Subscription on a topic.
# -------------------------------------------------------------
resource "azurerm_servicebus_subscription" "this" {
  name               = var.name
  topic_id           = var.topic_id
  max_delivery_count = var.max_delivery_count

  # Optional Settings
  auto_delete_on_idle                         = var.auto_delete_on_idle
  default_message_ttl                         = var.default_message_ttl
  lock_duration                               = var.lock_duration
  dead_lettering_on_message_expiration        = var.dead_lettering_on_message_expiration
  dead_lettering_on_filter_evaluation_error   = var.dead_lettering_on_filter_evaluation_error
  batched_operations_enabled                  = var.batched_operations_enabled
  requires_session                            = var.requires_session
  forward_to                                  = var.forward_to
  forward_dead_lettered_messages_to           = var.forward_dead_lettered_messages_to
  status                                      = var.status
  client_scoped_subscription_enabled          = var.client_scoped_subscription_enabled

  dynamic "client_scoped_subscription" {
    for_each = var.client_scoped_subscription != null ? [var.client_scoped_subscription] : []
    content {
      client_id                                 = client_scoped_subscription.value.client_id
      is_client_scoped_subscription_shareable   = client_scoped_subscription.value.is_shareable
      is_client_scoped_subscription_durable     = client_scoped_subscription.value.is_durable
    }
  }
}
