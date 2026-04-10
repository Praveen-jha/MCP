# output.tf
# This file defines the outputs for the User Assigned Identity module for Azure Data Factory credentials.
output "id" {
  description = "The ID of the Data Factory Credential User Managed Identity."
  value       = azurerm_data_factory_credential_user_managed_identity.this.id
}

output "name" {
  description = "The name of the Data Factory Credential User Managed Identity."
  value       = azurerm_data_factory_credential_user_managed_identity.this.name
}
