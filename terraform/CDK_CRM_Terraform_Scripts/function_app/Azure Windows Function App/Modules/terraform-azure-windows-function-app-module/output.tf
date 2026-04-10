output "id" {
  description = "The ID of the Function App."
  value       = azurerm_windows_function_app.this.id
}

output "name" {
  description = "The name of the Function App."
  value       = azurerm_windows_function_app.this.name
}

output "default_hostname" {
  description = "The default hostname of the Function App."
  value       = azurerm_windows_function_app.this.default_hostname
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses."
  value       = azurerm_windows_function_app.this.outbound_ip_addresses
}

output "outbound_ip_address_list" {
  description = "A list of outbound IP addresses."
  value       = azurerm_windows_function_app.this.outbound_ip_address_list
}

output "possible_outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses, not all of which are necessarily in use."
  value       = azurerm_windows_function_app.this.possible_outbound_ip_addresses
}

output "possible_outbound_ip_address_list" {
  description = "A list of outbound IP addresses, not all of which are necessarily in use."
  value       = azurerm_windows_function_app.this.possible_outbound_ip_address_list
}

output "identity" {
  description = "The identity block of the Function App."
  value       = azurerm_windows_function_app.this.identity
}

output "site_credential" {
  description = "The site credential block of the Function App."
  value       = azurerm_windows_function_app.this.site_credential
  sensitive   = true
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = azurerm_windows_function_app.this.custom_domain_verification_id
}

output "hosting_environment_id" {
  description = "The ID of the App Service Environment used by Function App."
  value       = azurerm_windows_function_app.this.hosting_environment_id
}

output "kind" {
  description = "The kind of the Function App."
  value       = azurerm_windows_function_app.this.kind
}
