# Azure Key Vault Resource Creation
resource "azurerm_key_vault" "kv" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = var.enabled_for_disk_encryption
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled
  public_network_access_enabled = var.public_network_access_enabled
  sku_name                      = var.sku_name
  enable_rbac_authorization     = var.enable_rbac_authorization

  # Contact Information
  dynamic "contact" {
    for_each = var.contact_name == "" ? [] : ["contact"]
    content {
      name  = var.contact_name
      email = var.contact_email
    }
  }
  network_acls {
    default_action             = "Deny"          # Restricting public access (CKV_AZURE_35)
    bypass                     = "AzureServices" # Allowing trusted Microsoft services
    ip_rules                   = var.network_rules_ip_rules
    virtual_network_subnet_ids = var.network_rules_virtual_network_subnet_ids
  }

  tags = var.tags

  # Lifecycle Settings
  lifecycle {
    ignore_changes = [contact]
  }
}

# Current client (Infra UAMI) must have access to run this workload successfully
data "azurerm_client_config" "current" {}

# Assign Key Vault Administrator Role to Current User
resource "azurerm_role_assignment" "key_role" {
  depends_on           = [azurerm_key_vault.kv]
  for_each             = toset(["Key Vault Secrets Officer", "Key Vault Crypto Officer"])
  scope                = azurerm_key_vault.kv.id
  role_definition_name = each.value
  principal_id         = data.azurerm_client_config.current.object_id # Assigns to the current user
}


# Key Vault Keys - Uses for_each to create multiple keys
resource "azurerm_key_vault_key" "key_vault_key" {
  depends_on = [azurerm_role_assignment.key_role]

  for_each        = var.key_definitions
  key_opts        = each.value.key_opts
  key_type        = each.value.key_type
  key_size        = each.value.key_size
  key_vault_id    = azurerm_key_vault.kv.id
  name            = each.key
  expiration_date = formatdate("YYYY-MM-DDTHH:MM:SSZ", timeadd(timestamp(), "8760h")) # 8760 hours = 3 years

  dynamic "rotation_policy" {
    for_each = each.value.available_rotation_policy == null ? [] : [1]
    content {
      automatic {
        time_before_expiry = each.value.rotation_policy_time_before_expiry
      }
      expire_after         = each.value.rotation_policy_expire_after
      notify_before_expiry = each.value.rotation_policy_notify_before_expiry
    }
  }
}

# Key Vault Secrets - Uses for_each to create multiple secrets
resource "azurerm_key_vault_secret" "kv_secret" {
  depends_on = [azurerm_role_assignment.key_role]

  for_each        = var.secret_definitions
  name            = each.key
  value           = each.value.secret_value
  key_vault_id    = azurerm_key_vault.kv.id
  expiration_date = formatdate("YYYY-MM-DDTHH:MM:SSZ", timeadd(timestamp(), "8760h")) # 8760 hours = 3 years
  content_type    = var.content_type

}
