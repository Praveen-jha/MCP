#output.tf
# This file defines the outputs for the SSIS Integration Runtime module for Azure.

output "id" {
  description = "The ID of the Azure-SSIS Integration Runtime"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.id
}

output "name" {
  description = "The name of the Azure-SSIS Integration Runtime"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.name
}

output "data_factory_id" {
  description = "The Data Factory ID"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.data_factory_id
}

output "location" {
  description = "The Azure location of the Integration Runtime"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.location
}

output "node_size" {
  description = "The size of the nodes"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.node_size
}

output "edition" {
  description = "The edition of the Integration Runtime"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.edition
}

output "license_type" {
  description = "The license type"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.license_type
}

output "max_parallel_executions_per_node" {
  description = "Maximum parallel executions per node"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.max_parallel_executions_per_node
}

output "number_of_nodes" {
  description = "Number of nodes"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.number_of_nodes
}

output "description" {
  description = "The description of the Integration Runtime"
  value       = azurerm_data_factory_integration_runtime_azure_ssis.this.description
}
