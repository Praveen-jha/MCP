output "identity_id" {
  description = "The ID of the user-assigned identity"
  value       = azurerm_user_assigned_identity.user_managed_identity.id
}

output "identity_principal_id" {
  description = "The principal ID of the user-assigned identity"
  value       = azurerm_user_assigned_identity.user_managed_identity.principal_id
}

output "identity_client_id" {
  description = "The client ID of the user-assigned identity"
  value       = azurerm_user_assigned_identity.user_managed_identity.client_id
}
