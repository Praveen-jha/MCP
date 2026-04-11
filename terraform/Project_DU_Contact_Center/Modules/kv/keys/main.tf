# This resource creates a key within an Azure Key Vault, defining options such as key type, size, and rotation policy, with optional notification settings and lifecycle configurations.
resource "azurerm_key_vault_key" "key_vault_key" {
  key_opts     = var.key_opts
  key_type     = var.key_type
  key_size     = var.key_size
  key_vault_id = var.key_vault_id
  name         = var.key_name

  # This dynamic block defines the rotation policy for the key, including automatic rotation settings, expiration duration, and notification preferences.
  dynamic "rotation_policy" {
    for_each = var.available_rotation_policy == null ? [] : [1]
    content {
      automatic {
        time_before_expiry = var.rotation_policy_time_before_expiry
      }
      expire_after         = var.rotation_policy_expire_after
      notify_before_expiry = var.rotation_policy_notify_before_expiry
    }
  }
}
