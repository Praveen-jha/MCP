output "resource_group" {
  description = "The entire resource object for the Azure Resource Group."
  value       = azurerm_resource_group.this
}

output "resource_group_id" {
  description = "The ID of the Azure Resource Group."
  value       = azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "The name of the Azure Resource Group."
  value       = azurerm_resource_group.this.name
}

output "resource_group_location" {
  description = "The Azure region where the Resource Group is deployed."
  value       = azurerm_resource_group.this.location
}