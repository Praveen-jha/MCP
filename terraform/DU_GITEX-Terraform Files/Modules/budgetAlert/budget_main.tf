data "azurerm_client_config" "current" {}

resource "azurerm_consumption_budget_subscription" "budget" {
  name            = var.budgetName
  subscription_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  amount          = var.amount
  time_grain      = var.timeGrain
  time_period {
    start_date = var.startDate
    end_date   = var.endDate
  }
  dynamic "notification" {
    for_each = var.notification
    content {
      enabled        = notification.value.enabled
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      threshold_type = notification.value.thresholdType
      contact_emails = notification.value.contact_emails
    }
  }
  lifecycle {
    ignore_changes = []
  }
}
