# Module: terraform_azure_servicebus_queue_authorization_rule_module
# Description: Dynamic module to create a Service Bus Queue Authorization Rule
# Registry Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue_authorization_rule

resource "azurerm_servicebus_queue_authorization_rule" "this" {
  name     = var.authorization_rule_name
  queue_id = var.queue_id
  listen   = var.listen
  send     = var.send
  manage   = var.manage
}
