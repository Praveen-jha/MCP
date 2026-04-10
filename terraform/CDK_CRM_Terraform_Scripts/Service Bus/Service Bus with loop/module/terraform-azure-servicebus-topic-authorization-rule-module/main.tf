
# Module: terraform-azure-servicebus-topic-authorization-rule
# Resource: azurerm_servicebus_topic_authorization_rule
# Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic_authorization_rule

resource "azurerm_servicebus_topic_authorization_rule" "this" {
  name     = var.auth_rule_name
  topic_id = var.topic_id
  listen   = var.listen
  send     = var.send
  manage   = var.manage
}
