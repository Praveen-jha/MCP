# Users, attach Users to Groups
# ————————————————————————————————————————————————————————————————
resource "azurerm_api_management_user" "users" {
  for_each            = var.users
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name

  user_id    = each.key
  first_name = each.value.first_name
  last_name  = each.value.last_name
  email      = each.value.email
  note       = try(each.value.note, null)
  state      = try(each.value.state, "active")
  password   = each.value.password                         # required for local APIM users
}



resource "azurerm_api_management_group_user" "group_user" {
  for_each            = { for gul in local.group_user_links : "${gul.group_key}|${gul.user_key}" => gul }
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name

  group_name = azurerm_api_management_group.groups[each.value.group_key].name
  user_id    = azurerm_api_management_user.users[each.value.user_key].user_id
}

