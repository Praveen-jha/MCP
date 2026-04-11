resource "azurerm_cognitive_account" "cognitive_account" {
  name                          = var.account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = var.kind
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled

  custom_subdomain_name = var.custom_subdomain_name
  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? [] : var.user_assigned_identity_id
  }

  lifecycle {
    ignore_changes = all
  }

}

resource "azurerm_cognitive_account_customer_managed_key" "cmk" {
  cognitive_account_id = azurerm_cognitive_account.cognitive_account.id
  key_vault_key_id     = var.key_vault_key_id
  identity_client_id   = var.user_assigned_identity_clientid
}
