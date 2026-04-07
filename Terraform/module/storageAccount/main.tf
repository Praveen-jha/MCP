resource "azurerm_storage_account" "storage_account" {
  name                          = var.storage_account_name
  resource_group_name           = var.rg_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  account_kind                  = var.account_kind
  shared_access_key_enabled     = var.shared_access_key_enabled
  is_hns_enabled                = var.is_hns_enabled
  public_network_access_enabled = var.public_network_access_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  tags                          = var.tags
  dynamic "network_rules" {
    for_each = var.network_rules == {} ? [] : ["Deny"]
    content {
      default_action = var.network_rules.default_action
      bypass         = var.network_rules.bypass
      ip_rules       = var.network_rules.ip_rules
    }
  }
  identity {
    type = var.storage_account_identity_type
  }
  lifecycle {
    ignore_changes = [
      network_rules,
      sftp_enabled,
      customer_managed_key,
      tags
    ]
  }
}
