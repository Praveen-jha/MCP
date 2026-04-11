resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.rg_name
  location                      = var.location
  sku                           = var.acr_sku
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled
  trust_policy_enabled          = var.trust_policy_enabled
  retention_policy_in_days      = var.retention_policy_in_days
  # Configure network rules
  network_rule_set {
    default_action = var.default_action
  }

  # Enable geo-replication for multi-region deployments (conditional)
  dynamic "georeplications" {
    for_each = var.geo_replication_enabled ? [1] : []
    content {
      location                  = var.geo_replication_location
      regional_endpoint_enabled = var.regional_endpoint_enabled
      zone_redundancy_enabled   = var.geo_zone_redundancy_enabled
    }
  }

  tags = var.acr_tags

  lifecycle {
    ignore_changes = []
  }
}
