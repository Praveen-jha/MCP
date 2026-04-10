resource "azurerm_cosmosdb_account" "db" {
  name                               = var.cosmos_db_name
  location                           = var.location
  resource_group_name                = var.rg_name
  offer_type                         = var.cosmos_offer_type
  kind                               = var.cosmos_kind
  automatic_failover_enabled         = var.cosmos_automatic_failover_enabled
  minimal_tls_version                = var.cosmos_min_tls_version
  access_key_metadata_writes_enabled = var.access_key_metadata_writes_enabled
  tags                               = var.tags
  default_identity_type              = var.default_identity_type

  consistency_policy {
    consistency_level       = var.cosmos_consistency_policy.consistency_level
    max_interval_in_seconds = var.cosmos_consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.cosmos_consistency_policy.max_staleness_prefix
  }

  backup {
    type                = var.cosmos_backup_type
    interval_in_minutes = var.cosmos_interval_in_minutes
    retention_in_hours  = var.cosmos_retention_in_hours
    tier                = var.cosmos_backup_tier
  }

  geo_location {
    location          = var.cosmos_geo_location.location
    failover_priority = var.cosmos_geo_location.failover_priority
  }

  identity {
    type         = var.cosmos_identity.type
    identity_ids = var.cosmos_identity.identity_ids
  }

  # Ensure Public Access is Disabled
  public_network_access_enabled = var.public_network_access_enabled

  # Restricting access to Virtual Network (VNet)
  # is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled
  # virtual_network_rule {
  #   id = var.vnet_id
  # }

  # Enabling Customer-Managed Keys (CMK)
  key_vault_key_id = var.key_vault_key_id

  # Disable Local Authentication
  local_authentication_disabled = var.local_authentication_disabled
}
