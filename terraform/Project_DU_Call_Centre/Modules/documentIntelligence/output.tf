output "diName" {
  description = "The name of the Document Intelligence"
  value       = azurerm_cognitive_account.documentIntelligence.name
}
output "diId" {
  description = "The ID of the Document Intelligence"
  value       = azurerm_cognitive_account.documentIntelligence.id
}

output "primary_access_key" {
  description = "Output: Azure Document Intelligence primary_access_key"
  value       = azurerm_cognitive_account.documentIntelligence.primary_access_key
}
