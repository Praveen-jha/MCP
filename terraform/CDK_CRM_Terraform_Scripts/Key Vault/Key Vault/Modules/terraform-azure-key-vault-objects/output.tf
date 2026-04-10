# # # outputs.tf
# # # Outputs for Key Vault Objects.

output "key_vault_certificate_id" {
  description = "The ID of the created Key Vault certificate (if created)."
  value = azurerm_key_vault_certificate.import_certificate.id
}
