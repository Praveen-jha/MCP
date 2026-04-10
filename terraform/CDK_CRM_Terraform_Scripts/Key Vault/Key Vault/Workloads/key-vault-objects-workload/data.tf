#Data block for Exsiting Key Vault

data "azurerm_key_vault" "keyvault_existing" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}
