# Groups (custom), attach Groups to Products
# ————————————————————————————————————————————————————————————————
resource "azurerm_api_management_group" "groups" {
  for_each            = var.groups
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name

  name         = each.key
  display_name = each.value.display_name
  description  = try(each.value.description, null)
  type         = "custom"
}

resource "azurerm_api_management_product_group" "product_group" {
  for_each            = { for pgl in local.product_group_links : "${pgl.product_key}|${pgl.group_key}" => pgl }
  resource_group_name =  var.resource_group_name
  api_management_name = azurerm_api_management.this.name

  product_id = azurerm_api_management_product.products[each.value.product_key].product_id
  group_name = azurerm_api_management_group.groups[each.value.group_key].name
}
