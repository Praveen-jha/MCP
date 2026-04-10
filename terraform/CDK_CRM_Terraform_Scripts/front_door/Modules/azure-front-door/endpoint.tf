resource "azurerm_cdn_frontdoor_endpoint" "my_endpoint" {
  for_each                 = toset(var.endpoint_name)
  name                     = each.value
  cdn_frontdoor_profile_id = local.front_door_profile_id
}
