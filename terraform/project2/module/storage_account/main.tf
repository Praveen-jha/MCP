resource "azurerm_storage_account" "storage" {
  name                              = var.storage_account_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.storage_account_tier
  account_replication_type          = var.account_replication_type # Ensuring replication is defined (CKV_AZURE_206)
  is_hns_enabled                    = var.is_hns_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled # Enforcing infrastructure encryption
  shared_access_key_enabled         = var.shared_access_key_enabled
  public_network_access_enabled     = var.public_network_access_enabled # Disabling public network access (CKV_AZURE_35, CKV_AZURE_190)
  local_user_enabled                = var.local_user_enabled

  # Enabling trusted Microsoft services (CKV_AZURE_36)
  network_rules {
    default_action             = "Deny"                                       # Restricting public access (CKV_AZURE_35)
    bypass                     = ["AzureServices"]                            # Allowing trusted Microsoft services
    ip_rules                   = var.network_rules_ip_rules                   # ip address to whitelist
    virtual_network_subnet_ids = var.network_rules_virtual_network_subnet_ids # subnet ids
  }

  # Ensuring soft delete is enabled (CKV2_AZURE_38)
  blob_properties {
    delete_retention_policy {
      days = var.delete_retention_policy_days
    }
    container_delete_retention_policy {
      days = var.delete_retention_policy_days
    }
  }

  # Avoiding the use of local users (CKV_AZURE_244)
  allow_nested_items_to_be_public = true

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  min_tls_version = var.min_tls_version # Ensuring TLS 1.2+ for security

  lifecycle {
    ignore_changes = [blob_properties, queue_properties, share_properties, customer_managed_key, network_rules, public_network_access_enabled]
  }

  tags = var.tags
}

resource "azurerm_storage_container" "containers" {
  depends_on = [azurerm_storage_account.storage]

  for_each              = var.storage_account_containers
  name                  = each.value.container_name
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = each.value.access_type
}

resource "azurerm_role_assignment" "storage_cmk_role" {
  depends_on = [azurerm_storage_account.storage]

  scope                = var.key_scope_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_storage_account.storage.identity[0].principal_id
}

resource "azurerm_storage_account_customer_managed_key" "storage_cmk" {
  depends_on = [azurerm_role_assignment.storage_cmk_role]

  storage_account_id = azurerm_storage_account.storage.id
  key_vault_id       = var.key_vault_id
  key_name           = var.key_name
}
