resource "azurerm_cdn_frontdoor_route" "routes" {
  depends_on = [azurerm_cdn_frontdoor_origin_group.origin_group, azurerm_cdn_frontdoor_origin.origin]
  for_each   = var.routes

  name                            = each.value.route_name
  cdn_frontdoor_endpoint_id       = data.azurerm_cdn_frontdoor_endpoint.endpoints[each.key].id
  cdn_frontdoor_origin_group_id   = data.azurerm_cdn_frontdoor_origin_group.origin_groups[each.key].id
  cdn_frontdoor_origin_ids        = local.origin_ids[each.key]
  cdn_frontdoor_custom_domain_ids = local.custom_domain_ids[each.key]
  cdn_frontdoor_rule_set_ids      = local.ruleset_ids[each.key]


  supported_protocols    = ["Http", "Https"]
  patterns_to_match      = ["/*"]
  forwarding_protocol    = "HttpsOnly"
  link_to_default_domain = true
  https_redirect_enabled = true
}
