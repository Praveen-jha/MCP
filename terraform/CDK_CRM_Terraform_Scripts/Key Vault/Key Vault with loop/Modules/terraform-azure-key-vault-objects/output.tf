# outputs.tf
# Outputs for Key Vault Objects.

output "key_vault_certificate_id" {
  description = "The ID of the created Key Vault certificate (if created)."
  value       = var.certificate_name != null ? azurerm_key_vault_certificate.import_certificate[0].id : null
}

output "key_vault_keys" {
  description = "Map of created Key Vault keys with their IDs and properties."
  value = {
    for key_name, key_resource in azurerm_key_vault_key.key_vault_key : key_name => {
      id       = key_resource.id
      name     = key_resource.name
      key_type = key_resource.key_type
      key_size = key_resource.key_size
    }
  }
}

output "key_vault_secrets" {
  description = "Map of created Key Vault secrets with their IDs (values are sensitive)."
  value = {
    for secret_name, secret_resource in azurerm_key_vault_secret.kv_secret : secret_name => {
      id   = secret_resource.id
      name = secret_resource.name
    }
  }
  sensitive = true
}