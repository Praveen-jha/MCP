# main.tf
# Description: # This file provisions an Azure Key Vault with optional networking and RBAC settings based on input variables.
# Terraform registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
# Azure Key Vault Resource Creation
resource "azurerm_key_vault" "this" {
  count                           = var.create_kv ? 1 : 0
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  sku_name                        = var.sku_name
  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  dynamic "access_policy" {
    for_each = var.enable_rbac_authorization == false ? var.key_vault_access_policies : []
    content {
      object_id               = access_policy.value.object_id
      tenant_id               = access_policy.value.tenant_id
      key_permissions         = lookup(access_policy.value, "key_permissions", [])
      secret_permissions      = lookup(access_policy.value, "secret_permissions", [])
      certificate_permissions = lookup(access_policy.value, "certificate_permissions", [])
      storage_permissions     = lookup(access_policy.value, "storage_permissions", [])
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : ["network_acls"]
    content {
      default_action             = var.network_acls.default_action
      bypass                     = var.network_acls.bypass
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  tags = var.tags
}

# Assign Key Vault Roles
resource "azurerm_role_assignment" "key_vault_role" {
  for_each             = var.create_kv ? toset(var.key_vault_roles) : toset([])
  scope                = azurerm_key_vault.this[0].id
  role_definition_name = each.value
  principal_id         = var.principal_id
  depends_on           = [azurerm_key_vault.this]
}
