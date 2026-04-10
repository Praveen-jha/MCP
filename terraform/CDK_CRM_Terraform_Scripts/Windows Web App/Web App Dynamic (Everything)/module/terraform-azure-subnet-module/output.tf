// output.tf
// This file defines the output values for the azurerm_subnet module.

output "subnet" {
  description = "The entire resource object for the Azure Subnet."
  value       = azurerm_subnet.this
}

output "subnet_id" {
  description = "The ID of the Azure Subnet."
  value       = azurerm_subnet.this.id
}

output "subnet_name" {
  description = "The name of the Azure Subnet."
  value       = azurerm_subnet.this.name
}

output "subnet_resource_group_name" {
  description = "The name of the Resource Group in which the Subnet is located."
  value       = azurerm_subnet.this.resource_group_name
}

output "subnet_virtual_network_name" {
  description = "The name of the Virtual Network to which the Subnet belongs."
  value       = azurerm_subnet.this.virtual_network_name
}

output "subnet_private_endpoint_network_policies" {
  description = "Network policies for the private endpoint on the Subnet (Enabled/Disabled/NetworkSecurityGroupEnabled/RouteTableEnabled)."
  value       = azurerm_subnet.this.private_endpoint_network_policies
}

output "subnet_private_link_service_network_policies_enabled" {
  description = "Indicates if network policies for the private link service are enabled on the Subnet."
  value       = azurerm_subnet.this.private_link_service_network_policies_enabled
}

output "subnet_default_outbound_access_enabled" {
  description = "Indicates if default outbound access is enabled for the Subnet."
  value       = azurerm_subnet.this.default_outbound_access_enabled
}

output "subnet_network_security_group_association" {
  description = "The entire object for the Subnet and NSG Association."
  value       = azurerm_subnet_network_security_group_association.this
}

output "subnet_network_security_group_association_id" {
  description = "The ID of the Azure Subnet and NSG Association."
  value       = azurerm_subnet_network_security_group_association.this.id
}

output "subnet_network_security_group_association_subnetId" {
  description = "The Id of the Subnet to which an NSG gets associated."
  value       = azurerm_subnet_network_security_group_association.this.subnet_id
}

output "subnet_network_security_group_association_nsgid" {
  description = "The Id of the NSG which gets associated to a Subnet."
  value       = azurerm_subnet_network_security_group_association.this.network_security_group_id
}
