# Manages a Virtual Machine Extension to provide post deployment configuration and run automated tasks.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension

resource "azurerm_virtual_machine_extension" "this" {
  name                        = var.virtual_machine_extension_name
  virtual_machine_id          = var.virtual_machine_id
  publisher                   = var.virtual_machine_extension_publisher
  type                        = var.virtual_machine_extension_type
  type_handler_version        = var.virtual_machine_extension_type_handler_version
  tags                        = var.virtual_machine_extension_tags
  auto_upgrade_minor_version  = try(var.virtual_machine_extension_auto_upgrade_minor_version, null)
  automatic_upgrade_enabled   = try(var.virtual_machine_extension_automatic_upgrade_enabled, null)
  failure_suppression_enabled = var.virtual_machine_extension_failure_suppression_enabled
  settings                    = try(var.virtual_machine_extension_settings, null)
  protected_settings          = try(jsonencode(var.virtual_machine_extension_protected_settings), null)
  provision_after_extensions  = try(var.virtual_machine_extension_provision_after_extensions, null)
  dynamic "protected_settings_from_key_vault" {
    for_each = var.virtual_machine_extension_protected_settings_from_key_vault == null ? [] : ["protected_settings_from_key_vault"]
    content {
      secret_url      = try(var.virtual_machine_extension_protected_settings_from_key_vault.secret_url, null)
      source_vault_id = try(var.virtual_machine_extension_protected_settings_from_key_vault.source_vault_id, null)
    }
  }
}