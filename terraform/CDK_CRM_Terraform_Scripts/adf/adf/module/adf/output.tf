// output.tf
// This file defines the output values for the azurerm_data_factory module.

output "data_factory" {
  description = "The entire resource object for the Azure Data Factory."
  value       = azurerm_data_factory.this
}

output "data_factory_id" {
  description = "The ID of the Azure Data Factory."
  value       = azurerm_data_factory.this.id
}

output "data_factory_name" {
  description = "The name of the Azure Data Factory."
  value       = azurerm_data_factory.this.name
}

output "data_factory_location" {
  description = "The Azure region where the Data Factory is deployed."
  value       = azurerm_data_factory.this.location
}

output "data_factory_resource_group_name" {
  description = "The principal ID associated with the Data Factory's managed identity."
  value       = azurerm_data_factory.this.resource_group_name
}

output "data_factory_public_network_enabled" {
  description = "Indicates if the public network access is enabled for the Data Factory."
  value       = azurerm_data_factory.this.public_network_enabled
}

output "data_factory_managed_vnet_enabled" {
  description = "Indicates whether the Managed Virtual Network is enabled for the Data Factory."
  value       = azurerm_data_factory.this.managed_virtual_network_enabled
}
