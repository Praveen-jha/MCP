# Resource to create Consumption Budget for Resource Group
resource "azurerm_consumption_budget_resource_group" "budget" {
  name              = var.budget_name
  resource_group_id = var.budget_resource_group_id # ID of the Resource Group to apply the budget to
  amount            = var.budget_amount
  time_grain        = var.budget_time_grain

  time_period {
    start_date = var.budget_start_date
    end_date   = var.budget_end_date
  }

  dynamic "notification" {
    for_each = var.budget_notifications
    content {
      enabled        = notification.value.enabled
      threshold      = notification.value.threshold
      operator       = notification.value.operator
      threshold_type = lookup(notification.value, "threshold_type", null)
      contact_emails = lookup(notification.value, "contact_emails", [])
      contact_groups = var.contact_groups
      contact_roles  = lookup(notification.value, "contact_roles", [])
    }
  }
}
