# Resource: azurerm_servicebus_namespace_disaster_recovery_config
# Description: Manages a Disaster Recovery Config for a Service Bus Namespace. 
# Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_disaster_recovery_config

resource "azurerm_servicebus_namespace_disaster_recovery_config" "this" {
  name                        = var.name
  primary_namespace_id        = var.primary_namespace_id
  partner_namespace_id        = var.partner_namespace_id
  alias_authorization_rule_id = var.alias_authorization_rule_id
}
