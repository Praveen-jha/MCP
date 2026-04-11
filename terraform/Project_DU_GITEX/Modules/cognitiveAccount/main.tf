resource "azurerm_cognitive_account" "cognitive_account" {
  name                          = var.account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = var.kind
  sku_name                      = var.sku_name
  local_auth_enabled            = var.local_auth_enabled
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }

  dynamic "customer_managed_key" {
    for_each = var.key_vault_key_id != "" ? [1] : []
    content {
      key_vault_key_id = var.key_vault_key_id != "" ? var.key_vault_key_id : null
    }
  }

  custom_subdomain_name = var.custom_subdomain_name

  tags = var.tags
}
