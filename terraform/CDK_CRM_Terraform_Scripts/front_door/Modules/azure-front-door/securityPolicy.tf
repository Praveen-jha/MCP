resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  for_each            = var.use_existing_waf_policy ? {} : local.waf_policies
  depends_on          = [azurerm_cdn_frontdoor_endpoint.my_endpoint, azurerm_cdn_frontdoor_origin_group.origin_group]
  name                = each.value.name
  resource_group_name = var.resource_group_name
  sku_name            = var.front_door_sku_name
  mode                = each.value.mode

  # Optional: Managed rules
  # managed_rule {
  #   type    = "DefaultRuleSet"
  #   version = "1.0"
  #   action  = "Block"
  # }
}

resource "azurerm_cdn_frontdoor_security_policy" "this" {
  for_each = local.waf_policies

  name                     = each.key
  cdn_frontdoor_profile_id = local.front_door_profile_id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = var.use_existing_waf_policy ? data.azurerm_cdn_frontdoor_firewall_policy.existing[each.key].id : azurerm_cdn_frontdoor_firewall_policy.this[each.key].id

      dynamic "association" {
        for_each = [
          for a in local.flattened_security_associations :
          a if a.waf_key == each.key
        ]

        content {
          domain {
            cdn_frontdoor_domain_id = data.azurerm_cdn_frontdoor_custom_domain.waf_domain[each.key].id
          }
          patterns_to_match = association.value.patterns_to_match
        }
      }
    }
  }
}
