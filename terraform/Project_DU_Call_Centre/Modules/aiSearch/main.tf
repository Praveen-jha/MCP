resource "azurerm_search_service" "ai_search" {
  name                                     = var.search_service_name
  resource_group_name                      = var.resource_group_name
  location                                 = var.location
  sku                                      = var.sku
  local_authentication_enabled             = var.local_authentication_enabled
  authentication_failure_mode              = var.authentication_failure_mode
  public_network_access_enabled            = var.public_network_access_enabled
  tags                                     = var.tags
  customer_managed_key_enforcement_enabled = var.customer_managed_key_enforcement_enabled
  semantic_search_sku                      = var.semantic_search_sku
  identity {
    type = var.identity_type
    #identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }
}

