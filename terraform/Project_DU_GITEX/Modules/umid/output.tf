output "umid" {
  description = "Output : Id of user managed identity resource object"
  value       = azurerm_user_assigned_identity.umid.id
}

output "umid_principal_id" {
  value = azurerm_user_assigned_identity.umid.principal_id
}

output "umid_client_id" {
  value = azurerm_user_assigned_identity.umid.client_id
}