# main.tf
# This configuration creates and manages cryptographic keys, secrets, and certificates within multiple existing Azure Key Vaults using for_each loop.

# Creating Key Vault objects for multiple Key Vaults using for_each loop
module "keyvault_objects" {
  source = "../../Modules/terraform-azure-key-vault-objects"
  
  # Using for_each to iterate over multiple Key Vault configurations
  for_each = var.kv_objects
  
  # Key Vault ID from data source using each.key to reference the specific Key Vault
  kv_id = data.azurerm_key_vault.keyvault_existing[each.key].id
  
  # Key definitions from each Key Vault configuration
  key_definitions = each.value.key_definitions
  
  # Secret definitions from each Key Vault configuration  
  secret_definitions = each.value.secret_definitions
  
  # Certificate configuration from each Key Vault configuration
  certificate_name     = each.value.certificate_name
  certificate_content  = each.value.certificate_content != null ? filebase64(each.value.certificate_content) : null
  certificate_password = each.value.certificate_password
}