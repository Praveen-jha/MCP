#outputs.tf
# Outputs key details of the Service Bus Namespace Customer Managed Key (CMK), including encryption settings and key identifiers.

output "namespace_customer_managed_key" {
  description = "Full resource object for the Service Bus Namespace Customer Managed Key."
  value       = azurerm_servicebus_namespace_customer_managed_key.this
}

output "id" {
  description = "The ID of the Service Bus Namespace Customer Managed Key resource."
  value       = azurerm_servicebus_namespace_customer_managed_key.this.id
}

output "infrastructure_encryption_enabled" {
  description = "Indicates whether infrastructure encryption is enabled for the Service Bus Namespace."
  value       = azurerm_servicebus_namespace_customer_managed_key.this.infrastructure_encryption_enabled
}

output "namespace_id" {
  description = "The ID of the associated Service Bus Namespace."
  value       = azurerm_servicebus_namespace_customer_managed_key.this.namespace_id
}

output "key_vault_key_id" {
  description = "The ID of the Key Vault Key used to encrypt data in the Service Bus Namespace."
  value       = azurerm_servicebus_namespace_customer_managed_key.this.key_vault_key_id
}
