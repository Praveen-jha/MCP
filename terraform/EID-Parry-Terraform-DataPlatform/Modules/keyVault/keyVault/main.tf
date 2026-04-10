data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.rg_name
  enabled_for_disk_encryption     = var.kv_enabled_for_disk_encryption
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = var.kv_soft_delete_retention_days
  purge_protection_enabled        = var.kv_purge_protection_enabled
  sku_name                        = var.kv_sku_name
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enabled_for_deployment          = var.enabled_for_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  public_network_access_enabled   = var.public_network_access_enabled
  tags                            = var.kv_tags
  dynamic "network_acls" {
    for_each = var.network_acls == {} ? [] : ["Deny"]
    content {
      default_action = var.network_acls.default_action
      bypass         = var.network_acls.bypass
      ip_rules       = var.network_acls.ip_rules
    }
  }
  lifecycle {
    ignore_changes = [
      network_acls,
      enabled_for_disk_encryption,
      enabled_for_deployment,
      enabled_for_template_deployment,
      purge_protection_enabled,
      enable_rbac_authorization,
      tags,
    ]
    prevent_destroy = true
  }
}