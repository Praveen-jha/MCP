// output.tf
// This file defines the output values for the azurerm_virtual_network module.

output "virtual_network" {
  description = "The entire resource object for the Azure Virtual Network."
  value       = azurerm_virtual_network.this
}

output "virtual_network_id" {
  description = "The ID of the Azure Virtual Network."
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "The name of the Azure Virtual Network."
  value       = azurerm_virtual_network.this.name
}

output "virtual_network_location" {
  description = "The Azure region where the Virtual Network is deployed."
  value       = azurerm_virtual_network.this.location
}

output "virtual_network_resource_group_name" {
  description = "The name of the Resource Group in which the Virtual Network is located."
  value       = azurerm_virtual_network.this.resource_group_name
}

output "virtual_network_bgp_community" {
  description = "The BGP Community assigned to the Virtual Network, if configured."
  value       = azurerm_virtual_network.this.bgp_community
}

output "virtual_network_edge_zone" {
  description = "The Edge Zone in which the Virtual Network is created, if configured."
  value       = azurerm_virtual_network.this.edge_zone
}

output "virtual_network_flow_timeout_in_minutes" {
  description = "The flow timeout in minutes for the Virtual Network, if configured."
  value       = azurerm_virtual_network.this.flow_timeout_in_minutes
}

output "virtual_network_private_endpoint_vnet_policies" {
  description = "Controls if Private Endpoint Network Policies are enabled on the Virtual Network, if configured."
  value       = azurerm_virtual_network.this.private_endpoint_vnet_policies
}
