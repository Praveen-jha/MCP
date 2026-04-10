data "azurerm_cdn_frontdoor_profile" "cdn_fd" {
  count               = var.existing_frontdoor ? 1 : 0
  name                = var.cdn_fd_name
  resource_group_name = var.resource_group_name
}

# Data: Endpoints
data "azurerm_cdn_frontdoor_endpoint" "endpoints" {
  depends_on          = [azurerm_cdn_frontdoor_endpoint.my_endpoint]
  for_each            = { for k, v in var.routes : k => v }
  name                = each.value.endpoint_name
  profile_name        = local.front_door_profile_name
  resource_group_name = var.resource_group_name
}

# Data: Origin Groups
data "azurerm_cdn_frontdoor_origin_group" "origin_groups" {
  depends_on          = [azurerm_cdn_frontdoor_origin_group.origin_group]
  for_each            = { for k, v in var.routes : k => v }
  name                = each.value.origin_group_name
  profile_name        = local.front_door_profile_name
  resource_group_name = var.resource_group_name
}

# Data: Custom Domains
data "azurerm_cdn_frontdoor_custom_domain" "custom_domains" {
  depends_on = [azurerm_cdn_frontdoor_custom_domain.fd_custom_domain, azurerm_cdn_frontdoor_firewall_policy.this]
  for_each   = local.flat_custom_domain_map

  name                = each.value
  profile_name        = local.front_door_profile_name
  resource_group_name = var.resource_group_name
}



# Data: Rule Sets
data "azurerm_cdn_frontdoor_rule_set" "rulesets" {
  depends_on = [azurerm_cdn_frontdoor_rule_set.rule_set, azurerm_cdn_frontdoor_firewall_policy.this]
  for_each   = local.flat_ruleset_map

  name                = each.value
  profile_name        = local.front_door_profile_name
  resource_group_name = var.resource_group_name
}

data "azurerm_cdn_frontdoor_origin_group" "existing" {
  depends_on          = [azurerm_cdn_frontdoor_origin_group.origin_group, azurerm_cdn_frontdoor_firewall_policy.this]
  for_each            = var.use_existing_origin_group ? local.origin_groups : {}
  name                = each.value.name
  profile_name        = local.front_door_profile_name
  resource_group_name = var.resource_group_name
}

data "azurerm_cdn_frontdoor_rule_set" "existing" {
  depends_on = [azurerm_cdn_frontdoor_rule_set.rule_set]
  for_each   = var.use_existing_rulesets ? local.rule_sets : {}

  name                = each.value.name
  profile_name        = local.front_door_profile_name
  resource_group_name = var.resource_group_name
}

data "azurerm_cdn_frontdoor_firewall_policy" "existing" {
  depends_on = [azurerm_cdn_frontdoor_firewall_policy.this]
  for_each   = var.use_existing_waf_policy ? local.waf_policies : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_certificate" "cert" {
  for_each = var.custom_domains

  name         = each.value.cert_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault" "kv" {
  for_each = var.custom_domains

  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group
}

data "azurerm_cdn_frontdoor_custom_domain" "waf_domain" {
  depends_on = [azurerm_cdn_frontdoor_custom_domain.fd_custom_domain]
  for_each   = var.waf_policies

  name                = each.value.domain_name
  resource_group_name = var.resource_group_name
  profile_name        = var.cdn_fd_name
}

data "azurerm_cdn_frontdoor_secret" "fd_secret" {
  for_each = var.use_existing_secret ? var.custom_domains : {}

  name                = each.value.cert_name
  resource_group_name = var.resource_group_name
  profile_name        = var.cdn_fd_name
}
