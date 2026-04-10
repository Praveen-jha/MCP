resource "azurerm_monitor_action_group" "action_group" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_shortname

dynamic "email_receiver" {
  for_each = var.email_receivers
  content {
    name          = email_receiver.value.name
    email_address = email_receiver.value.email_address
  }
}

}