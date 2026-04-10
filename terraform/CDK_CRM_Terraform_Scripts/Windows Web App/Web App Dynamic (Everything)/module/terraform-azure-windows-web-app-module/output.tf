// output.tf
// This file defines the output values for the azurerm_windows_web_app module.

output "windows_web_app" {
  description = "TThe entire resource object for the Azure Windows Web App."
  value       = azurerm_windows_web_app.this
}

output "windows_web_app_id" {
  description = "The ID of the Azure Windows Web App."
  value       = azurerm_windows_web_app.this.id
}

output "windows_web_app_default_hostname" {
  description = "The default hostname of the Azure Windows Web App (e.g., yourwebapp.azurewebsites.net)."
  value       = azurerm_windows_web_app.this.default_hostname
}

output "windows_web_app_outbound_ip_address_list" {
  description = "A list of outbound IP addresses associated with the web app."
  value       = azurerm_windows_web_app.this.outbound_ip_address_list
}

output "windows_web_app_outbound_ip_addresses_string" {
  description = "A comma-separated string of outbound IP addresses for the web app."
  value       = azurerm_windows_web_app.this.outbound_ip_addresses
}

output "windows_web_app_client_affinity_enabled" {
  description = "Indicates if client affinity (sticky sessions) is enabled for the web app."
  value       = azurerm_windows_web_app.this.client_affinity_enabled
}

output "windows_web_app_client_certificate_enabled" {
  description = "Indicates if client certificate authentication is enabled."
  value       = azurerm_windows_web_app.this.client_certificate_enabled
}

output "windows_web_app_client_certificate_mode" {
  description = "The client certificate mode (e.g., 'Required', 'Optional')."
  value       = azurerm_windows_web_app.this.client_certificate_mode
}

output "windows_web_app_client_certificate_exclusion_paths" {
  description = "A list of paths for which client certificate authentication is excluded."
  value       = azurerm_windows_web_app.this.client_certificate_exclusion_paths
}

output "windows_web_app_custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = azurerm_windows_web_app.this.custom_domain_verification_id
}

output "windows_web_app_enabled" {
  description = "Indicates if the Windows Web App is enabled."
  value       = azurerm_windows_web_app.this.enabled
}

output "windows_web_app_https_only" {
  description = "Indicates if the Windows Web App requires HTTPS connections only."
  value       = azurerm_windows_web_app.this.https_only
}

output "windows_web_app_key_vault_reference_identity_id" {
  description = "The ID of the Managed Identity to use for Key Vault references."
  value       = azurerm_windows_web_app.this.key_vault_reference_identity_id
}

output "windows_web_app_virtual_network_subnet_id" {
  description = "The ID of the Virtual Network Subnet integrated with the web app."
  value       = azurerm_windows_web_app.this.virtual_network_subnet_id
}

output "windows_web_app_zip_deploy_file" {
  description = "The path to the ZIP file containing the web app content for deployment."
  value       = azurerm_windows_web_app.this.zip_deploy_file
}

output "windows_web_app_hosting_environment_id" {
  description = "The ID of the App Service Environment used by App Service (if applicable)."
  value       = try(azurerm_windows_web_app.this.hosting_environment_id, null)
}

output "windows_web_app_kind" {
  description = "The string representation of the Windows Web App Kind."
  value       = try(azurerm_windows_web_app.this.kind, null)
}

output "windows_web_app_location" {
  description = "The Azure Region where the Windows Web App exists."
  value       = azurerm_windows_web_app.this.location
}

output "windows_web_app_name" {
  description = "The name of the Windows Web App."
  value       = azurerm_windows_web_app.this.name
}

output "windows_web_app_resource_group_name" {
  description = "The name of the Resource Group where the Windows Web App exists."
  value       = azurerm_windows_web_app.this.resource_group_name
}

output "windows_web_app_service_plan_id" {
  description = "The ID of the Service Plan in which this Windows Web App resides."
  value       = azurerm_windows_web_app.this.service_plan_id
}

output "windows_web_app_identity_principal_id" {
  description = "The Principal ID of the Managed Service Identity assigned to the web app (if configured)."
  value       = try(azurerm_windows_web_app.this.identity[0].principal_id, null)
}

output "windows_web_app_identity_tenant_id" {
  description = "The Tenant ID of the Managed Service Identity assigned to the web app (if configured)."
  value       = try(azurerm_windows_web_app.this.identity[0].tenant_id, null)
}

output "windows_web_app_identity_type" {
  description = "The type of Managed Service Identity assigned to the web app (e.g., 'SystemAssigned', 'UserAssigned')."
  value       = try(azurerm_windows_web_app.this.identity[0].type, null)
}

output "windows_web_app_identity_ids" {
  description = "A list of user-assigned identity IDs (if the identity type is UserAssigned)."
  value       = try(azurerm_windows_web_app.this.identity[0].identity_ids, null)
}

output "windows_web_app_app_settings" {
  description = "A map of application settings configured for the web app."
  value       = azurerm_windows_web_app.this.app_settings
}
