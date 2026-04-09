resource "azurerm_linux_function_app" "function_app_linux" {
  name                          = var.name
  resource_group_name           = var.rg_name
  location                      = var.location
  storage_account_name          = var.storage_account_name
  service_plan_id               = var.asp_id
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
  virtual_network_subnet_id     = var.virtual_network_subnet_id
  https_only                    = var.https_only
  storage_uses_managed_identity = var.storage_uses_managed_identity
  # storage_account_access_key = var.storage_key

  site_config {}

  identity {
    type         = var.function_identity.type
    identity_ids = var.function_identity.identity_ids
  }

  lifecycle {
    ignore_changes = [app_settings, site_config, sticky_settings, tags]
  }
}
