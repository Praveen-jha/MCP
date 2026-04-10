/**
 * Manages a ServiceBus Namespace Authorization Rule within a ServiceBus Namespace.
 * Terraform Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule
 */

resource "azurerm_servicebus_namespace_authorization_rule" "this" {
  name         = var.namespace_authorization_rule_name
  namespace_id = var.servicebus_namespace_id
  listen       = var.listen
  send         = var.send
  manage       = var.manage
}
