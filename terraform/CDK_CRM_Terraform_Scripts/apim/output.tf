// output.tf
// This file defines the output values for the azurerm_api_management module.
output "apim_id" {
  description = "The ID of the API Management service."
  value       = azurerm_api_management.this.id
}

output "apim_name" {
  description = "The name of the API Management service."
  value       = azurerm_api_management.this.name
}

output "apim_gateway_url" {
  description = "The URL of the API Management gateway."
  value       = azurerm_api_management.this.gateway_url
}

output "apim_public_ip_addresses" {
  description = "A list of the Public IP Addresses of the API Management Service."
  value       = azurerm_api_management.this.public_ip_addresses
}

output "apim_private_ip_addresses" {
  description = "A list of the Private IP Addresses of the API Management Service. Only available when the virtual_network_type is set to 'Internal' or 'External'."
  value       = azurerm_api_management.this.private_ip_addresses
}
output "api_management_logger_id" {
  value = var.app_insight_enabled ? azurerm_api_management_logger.appinsights[0].id : null
}

output "subscription_keys" {
  value = {
    for k, s in azurerm_api_management_subscription.subs : k => {
      primary_key   = s.primary_key
      secondary_key = s.secondary_key
    }
  }
  sensitive = true
}