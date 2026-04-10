# Resource to create moniter action group.
resource "azurerm_monitor_action_group" "action_group" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name
  dynamic "email_receiver" {
    for_each = var.email_details
    content {    
      name          = email_receiver.key
      email_address = email_receiver.value
    }
  }
}
