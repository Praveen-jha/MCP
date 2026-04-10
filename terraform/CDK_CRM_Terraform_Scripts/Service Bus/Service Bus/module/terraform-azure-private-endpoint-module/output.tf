// output.tf
// This file defines the output values for the azurerm_private_endpoint module.

output "private_endpoint" {
  description = "The entire resource object for the Private Endpoint."
  value       = azurerm_private_endpoint.this
}

output "private_endpoint_id" {
    description = "The ID of the Private Endpoint."
    value       = azurerm_private_endpoint.this.id
}
 
output "private_endpoint_network_interface" {
    description = "The network interface of the Private Endpoint."
    value       = azurerm_private_endpoint.this.network_interface
}
 
output "private_endpoint_custom_dns_configs" {
    description = "Custom DNS configs for the Private Endpoint."
    value       = azurerm_private_endpoint.this.custom_dns_configs
}
 
output "private_endpoint_private_dns_zone_configs" {
    description = "Private DNS zone configs for the Private Endpoint."
    value       = azurerm_private_endpoint.this.private_dns_zone_configs
}
 