resource "azurerm_cognitive_account" "documentIntelligence" {
  name                          = var.document_intelligence_name
  location                      = var.location
  resource_group_name           = var.rgName
  kind                          = var.diKind
  sku_name                      = var.diSkuName
  public_network_access_enabled = var.publiceNetworkAccessEnabled
  tags                          = var.diTags
  custom_subdomain_name         = var.diCustomSubdomain
  
  customer_managed_key {
    identity_client_id = var.user_assigned_identity_id
    key_vault_key_id = var.key_vault_key_id
  }
  identity {
    type = var.identityType
    identity_ids = var.identity_ids
  }
}
