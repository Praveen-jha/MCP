resource "azurerm_cdn_frontdoor_profile" "my_front_door" {
  count               = var.existing_frontdoor ? 0 : 1
  name                = var.cdn_fd_name
  resource_group_name = var.resource_group_name
  sku_name            = var.front_door_sku_name
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "fd_secret_user" {
  for_each = var.existing_frontdoor ? {} : var.custom_domains

  scope                = data.azurerm_key_vault.kv[each.key].id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = local.cdn_principal_id
}

# resource "azurerm_role_assignment" "fd_certificate_user" {
#   for_each = (var.existing_frontdoor && false) ? {} : var.custom_domains

#   scope                = data.azurerm_key_vault.kv[each.key].id
#   role_definition_name = "Key Vault Certificates Officer"
#   principal_id         = local.cdn_principal_id
# }
