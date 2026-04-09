output "principal_id" {
  description = "The principal ID of the managed identity associated with the cognitive account"
  value       = azurerm_cognitive_account.cognitive_account.identity[0].principal_id
}

output "account_id" {
  description = "The unique resource ID of the cognitive account"
  value       = azurerm_cognitive_account.cognitive_account.id
}
