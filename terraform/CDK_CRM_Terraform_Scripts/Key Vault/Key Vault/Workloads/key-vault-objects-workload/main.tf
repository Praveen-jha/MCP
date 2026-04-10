# #Creation of Key Vault Objects including Key Vault Secrets, Certificates and Keys.

# main.tf
# This module creates and manages cryptographic keys, secrets, and certificates within an existing Azure Key Vault by importing configuration definitions and certificate files.
module "keyvault_objects" {
  source = "../../Modules/terraform-azure-key-vault-objects"
  
  key_vault_id = data.azurerm_key_vault.keyvault_existing.id
  
  # Key definitions
  key_definitions = var.key_definitions
  
  # Secret definitions
  secret_definitions = var.secret_definitions
  
  # Certificate configuration
  certificate_name     = var.certificate_name
  certificate_content  = var.certificate_content != null ? filebase64(var.certificate_content) : null
  certificate_password = var.certificate_password
}

