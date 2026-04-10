output "id" {
  description = "The ID of the Linux Function App"
  value       = azurerm_linux_function_app.this.id
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record"
  value       = azurerm_linux_function_app.this.custom_domain_verification_id
}

output "default_hostname" {
  description = "The default hostname of the Linux Function App"
  value       = azurerm_linux_function_app.this.default_hostname
}

output "identity" {
  description = "An identity block, which contains the Managed Service Identity information for this App Service"
  value       = azurerm_linux_function_app.this.identity
}

output "kind" {
  description = "The Kind value for this Linux Function App"
  value       = azurerm_linux_function_app.this.kind
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses"
  value       = azurerm_linux_function_app.this.outbound_ip_addresses
}

output "outbound_ip_address_list" {
  description = "A list of outbound IP addresses"
  value       = azurerm_linux_function_app.this.outbound_ip_address_list
}

output "possible_outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses - not all of which are necessarily in use"
  value       = azurerm_linux_function_app.this.possible_outbound_ip_addresses
}

output "possible_outbound_ip_address_list" {
  description = "A list of outbound IP addresses - not all of which are necessarily in use"
  value       = azurerm_linux_function_app.this.possible_outbound_ip_address_list
}

output "site_credential" {
  description = "A site_credential block containing the authentication information"
  value       = azurerm_linux_function_app.this.site_credential
  sensitive   = true
}
