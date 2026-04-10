// output.tf
// This file defines the output values for the azurerm_application_insights module.

output "application_insights_id" {
  description = "The ID of the Application Insights instance."
  value       = azurerm_application_insights.this.id
}

output "application_insights_app_id" {
  description = "The App ID associated with this Application Insights component."
  value       = azurerm_application_insights.this.app_id
}

output "application_insights_instrumentation_key" {
  description = "The Instrumentation Key of the Application Insights instance."
  value       = azurerm_application_insights.this.instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "The Connection String for this Application Insights component."
  value       = azurerm_application_insights.this.connection_string
  sensitive   = true
}
