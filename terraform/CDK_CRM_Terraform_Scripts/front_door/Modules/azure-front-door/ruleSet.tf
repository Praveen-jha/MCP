resource "azurerm_cdn_frontdoor_rule_set" "rule_set" {
  depends_on = [azurerm_cdn_frontdoor_origin_group.origin_group, azurerm_cdn_frontdoor_origin.origin]

  for_each = var.use_existing_rulesets ? {} : local.rule_sets

  name                     = each.value.name
  cdn_frontdoor_profile_id = local.front_door_profile_id
}

resource "azurerm_cdn_frontdoor_rule" "rule_set_rule" {
  for_each = {
    for rule in local.flattened_rules : "${rule.ruleset_key}-${rule.rule_name}" => rule
  }

  name                      = each.value.rule_name
  cdn_frontdoor_rule_set_id = var.use_existing_rulesets ? data.azurerm_cdn_frontdoor_rule_set.existing[each.value.ruleset_key].id : azurerm_cdn_frontdoor_rule_set.rule_set[each.value.ruleset_key].id

  order = each.value.rule_config.order

  dynamic "actions" {
    for_each = each.value.rule_config.type == "rewrite" ? [1] : []
    content {
      url_rewrite_action {
        source_pattern          = each.value.rule_config.source
        destination             = each.value.rule_config.destination
        preserve_unmatched_path = coalesce(each.value.rule_config.preserve, true)
      }
    }
  }
  dynamic "actions" {
    for_each = each.value.rule_config.type == "redirect" ? [1] : []
    content {
      url_redirect_action {
        redirect_type        = each.value.rule_config.redirect_type
        destination_hostname = each.value.rule_config.destination
      }
    }
  }
}