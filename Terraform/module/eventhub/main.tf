resource "azurerm_eventhub_namespace" "eventhub" {
  name                          = var.evenhub_namespace_name
  location                      = var.eventhub_namespace_location
  resource_group_name           = var.evenhub_namespace_rg
  sku                           = var.evenhub_namespace_sku
  capacity                      = var.eventhub_namespace_capacity
  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.eventhub_namespace_public_network_access_enabled
  auto_inflate_enabled          = var.eventhub_namespace_auto_inflate_enabled
  maximum_throughput_units      = var.eventhub_namespace_max_throughput_units
  tags                          = var.tags
  identity {
    type = var.evenhub_namespace_identity_type
  }
  lifecycle {
    ignore_changes = [
      # sku,
      # capacity,
      # public_network_access_enabled,
      # maximum_throughput_units,
      # auto_inflate_enabled,
      # tags
    ]
  }
}