resource "azurerm_search_service" "ai_search" {
  name                          = var.ai_search_name
  resource_group_name           = var.ai_search_rg_name
  location                      = var.ai_search_rg_location
  public_network_access_enabled = var.public_network_access_enabled
  hosting_mode                  = var.ai_service_hosting_mode
  partition_count               = var.ai_partition_count
  replica_count                 = var.ai_replica_count
  sku                           = var.ai_search_sku
  identity {
    type = var.ai_search_identity
  }
  tags = var.ai_search_tag
}
