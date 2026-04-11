resource "azurerm_storage_account" "storage_account" {
  name                          = var.storageAccountName
  resource_group_name           = var.rgName
  location                      = var.location
  account_tier                  = var.accountTier
  account_replication_type      = var.accountReplicationType
  account_kind                  = var.accountKind
  enable_https_traffic_only     = var.enableHttpsTrafficOnly
  min_tls_version               = var.minTlsVersion
  shared_access_key_enabled     = var.sharedAccessKeyEnabled
  is_hns_enabled                = var.isHnsEnabled
  public_network_access_enabled = var.publicNetworkAccessEnabled
  tags                          = var.tags
  dynamic "network_rules" {
    for_each = var.networkRules == {} ? [] : ["Deny"]
    content {
      default_action             = var.networkRules.defaultAction
      bypass                     = var.networkRules.bypass
      ip_rules                   = var.networkRules.ipRules
    }
  }
}
