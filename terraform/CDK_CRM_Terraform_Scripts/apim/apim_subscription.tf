# Subscriptions (Product + User)
# ————————————————————————————————————————————————————————————————
resource "azurerm_api_management_subscription" "subs" {
  for_each            = var.subscriptions
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name

  display_name = each.value.display_name
  product_id   = azurerm_api_management_product.products[each.value.product_key].id
  user_id      = azurerm_api_management_user.users[each.value.user_key].id
  state        = "active"
}


