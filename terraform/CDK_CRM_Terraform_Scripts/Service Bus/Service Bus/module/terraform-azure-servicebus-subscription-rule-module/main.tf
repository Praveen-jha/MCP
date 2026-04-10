# Module: terraform-azure-servicebus-subscription-rule
# Resource: azurerm_servicebus_subscription_rule
# Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule

resource "azurerm_servicebus_subscription_rule" "this" {
  name            = var.name
  subscription_id = var.subscription_id
  filter_type     = var.filter_type

  dynamic "correlation_filter" {
    for_each = var.filter_type == "CorrelationFilter" && var.correlation_filter != null ? [1] : []
    content {
      content_type        = lookup(var.correlation_filter, "content_type", null)
      correlation_id      = lookup(var.correlation_filter, "correlation_id", null)
      label               = lookup(var.correlation_filter, "label", null)
      message_id          = lookup(var.correlation_filter, "message_id", null)
      reply_to            = lookup(var.correlation_filter, "reply_to", null)
      reply_to_session_id = lookup(var.correlation_filter, "reply_to_session_id", null)
      session_id          = lookup(var.correlation_filter, "session_id", null)
      to                  = lookup(var.correlation_filter, "to", null)
      properties          = lookup(var.correlation_filter, "properties", null)
    }
  }

  dynamic "sql_filter" {
    for_each = var.filter_type == "SqlFilter" && var.sql_filter != null ? [1] : []
    content {
      value = var.sql_filter
    }
  }

  action = var.action
}
 
