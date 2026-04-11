resource "azurerm_cognitive_account" "cognitive_account" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.rg_name
  kind                          = var.kind
  sku_name                      = var.sku_name
  public_network_access_enabled = var.publice_network_access_enabled
  custom_subdomain_name         = var.custom_subdomain
  tags                          = var.tags
  local_auth_enabled            = var.local_auth_enabled

  identity {
    type = var.cognitive_identity
  }
}

resource "azurerm_role_assignment" "cmk_role" {
  depends_on           = [azurerm_cognitive_account.cognitive_account]
  scope                = var.key_scope_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_cognitive_account.cognitive_account.identity[0].principal_id
}

resource "azurerm_cognitive_account_customer_managed_key" "cognitive_cmk" {
  depends_on           = [azurerm_role_assignment.cmk_role]
  cognitive_account_id = azurerm_cognitive_account.cognitive_account.id
  key_vault_key_id     = var.key_vault_key_id
}
