output "application_insights" {
  value = azurerm_application_insights.application_insights.app_id
}

output "application_insights_id" {
  value = azurerm_application_insights.application_insights.id
}

output "instrumentation_key" {
  value = azurerm_application_insights.application_insights.instrumentation_key
}

output "connection_string" {
  value = azurerm_application_insights.application_insights.connection_string
}