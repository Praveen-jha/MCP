resource "azurerm_storage_account" "logic_app_storage_account" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  public_network_access_enabled = false
}

resource "azurerm_storage_share" "logic_app_storage_account_share" {
  name               = var.storage_accoun_content_share_name
  storage_account_id = azurerm_storage_account.logic_app_storage_account.id 
  quota              = "5000"
}

# private endpoint for storage account
resource "azurerm_private_endpoint" "storage_pe" {
  count               = 4
  name                = "pep-${element(["blob", "file", "table", "queue"], count.index)}-${var.storage_account_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.storage_pe_subnet_id

  private_service_connection {
    name                           = "peps-${element(["blob", "file", "table", "queue"], count.index)}-${var.storage_account_name}"
    private_connection_resource_id = azurerm_storage_account.logic_app_storage_account.id
    subresource_names              = [element(["blob", "file", "table", "queue"], count.index)]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "rec-${element(["blob", "file", "table", "queue"], count.index)}-${var.storage_account_name}"
    private_dns_zone_ids = [
      element(var.private_dns_zone_ids, count.index)
    ]

  }
  depends_on = [azurerm_storage_share.logic_app_storage_account_share]
}

resource "azurerm_service_plan" "logic_app_plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                       = var.logic_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_service_plan.logic_app_plan.id
  storage_account_name       = azurerm_storage_account.logic_app_storage_account.name
  storage_account_access_key = azurerm_storage_account.logic_app_storage_account.primary_access_key
  virtual_network_subnet_id  = var.logic_app_subnet_id
  public_network_access      = var.logic_app_public_access_enabled
  identity {
    type = var.logic_app_identity_type
  }
  app_settings = {
    "WEBSITE_VNET_ROUTE_ALL"       = "1"
    "WEBSITE_CONTENTOVERVNET"      = "1"
    "FUNCTIONS_WORKER_RUNTIME"     = var.functions_worker_runtime
    "WEBSITE_DNS_SERVER"           = var.website_dns_server
    "WEBSITE_NODE_DEFAULT_VERSION" = var.website_node_default_version

  }
  depends_on = [azurerm_private_endpoint.storage_pe]
}

# resource "azurerm_role_assignment" "logicapp_roles" {
#   count = 4
#   scope = azurerm_storage_account.logic_app_storage_account.id
#   role_definition_name = element([
#     "Storage Blob Data Owner",
#     "Storage Account Contributor",
#     "Storage Table Data Contributor",
#     "Storage File Data Privileged Contributor"
#   ], count.index)
#   principal_id = azurerm_logic_app_standard.logic_app.identity[0].principal_id
#   depends_on = [azurerm_logic_app_standard.logic_app, azurerm_storage_account.logic_app_storage_account]
# }

