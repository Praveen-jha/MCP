/**
 * Manages a Service Bus Namespace Customer Managed Key.
 * Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_customer_managed_key
 *
 * NOTE:
 * - Only for Service Bus Namespace with System Assigned Identity.
 * - Cannot be removed without deleting the parent namespace.
 */

resource "azurerm_servicebus_namespace_customer_managed_key" "this" {
  namespace_id                      = var.namespace_id
  key_vault_key_id                  = var.key_vault_key_id
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
}
