output "secret" {
  description = "Output: Secrets of Key Vault."
  value       = azurerm_key_vault_secret.kv_secret
}
