resource "azurerm_disk_encryption_set" "disk_ency_set" {
  name                = var.disk_encryption_set_name
  resource_group_name = var.rg_name
  location            = var.location
  key_vault_key_id    = var.key_vault_id

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
  tags = var.tags
}
