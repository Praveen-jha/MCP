# Products (published), and attach APIs to Products
# ————————————————————————————————————————————————————————————————
resource "azurerm_api_management_product" "products" {
  for_each            = var.products
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name

  product_id          = each.key
  display_name        = each.value.display_name
  description         = try(each.value.description, null)
  approval_required   = try(each.value.approval_required, false)
  subscriptions_limit = try(each.value.subscriptions_limit, 0)
  published           = try(each.value.published, true)
  terms               = try(each.value.terms, null)
}



resource "azurerm_api_management_product_api" "product_api" {
  for_each            = { for pal in local.product_api_links : "${pal.product_key}|${pal.api_key}" => pal }
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name

  product_id = azurerm_api_management_product.products[each.value.product_key].product_id
api_name   = azurerm_api_management_api.apis[each.value.api_key].name  
}
