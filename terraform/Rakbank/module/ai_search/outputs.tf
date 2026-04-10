output "ai_search_name" {
  description = "The name of the Search Service"
  value       = azurerm_search_service.ai_search.name
}
output "principal_id" {
  description = "The ID of the Search Service"
  value       = azurerm_search_service.ai_search.identity[0].principal_id
}
output "account_id" {
  description = "The resource ID of the Azure Search Service"
  value       = azurerm_search_service.ai_search.id
}
