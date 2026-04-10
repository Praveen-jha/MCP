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

