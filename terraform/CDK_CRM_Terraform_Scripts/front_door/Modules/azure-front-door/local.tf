
# Local: Construct origin IDs from origin group ID
locals {


  front_door_profile_id   = var.existing_frontdoor ? data.azurerm_cdn_frontdoor_profile.cdn_fd[0].id : azurerm_cdn_frontdoor_profile.my_front_door[0].id
  front_door_profile_name = var.existing_frontdoor ? data.azurerm_cdn_frontdoor_profile.cdn_fd[0].name : azurerm_cdn_frontdoor_profile.my_front_door[0].name
  cdn_principal_id        = var.existing_frontdoor ? data.azurerm_cdn_frontdoor_profile.cdn_fd[0].identity[0].principal_id : azurerm_cdn_frontdoor_profile.my_front_door[0].identity[0].principal_id



  origin_ids = {
    for route_key, route_value in var.routes :
    route_key => [
      for origin_name in route_value.origin_names :
      "${data.azurerm_cdn_frontdoor_origin_group.origin_groups[route_key].id}/origins/${origin_name}"
    ]
  }

  custom_domain_ids = {
    for route_key in keys(var.routes) : route_key => [
      for domain_name in var.routes[route_key].custom_domain_names :
      data.azurerm_cdn_frontdoor_custom_domain.custom_domains["${route_key}${domain_name}"].id
    ]
  }

  ruleset_ids = {
    for route_key in keys(var.routes) : route_key => [
      for ruleset_name in var.routes[route_key].ruleset_names :
      data.azurerm_cdn_frontdoor_rule_set.rulesets["${route_key}${ruleset_name}"].id
    ]
  }


  flat_ruleset_map = merge(
    [
      for route_key, route_value in var.routes : {
        for ruleset_name in route_value.ruleset_names :
        "${route_key}${ruleset_name}" => ruleset_name
      }
    ]...
  )



  flat_custom_domain_map = merge(
    [
      for route_key, route_value in var.routes : {
        for domain_name in route_value.custom_domain_names :
        "${route_key}${domain_name}" => domain_name
      }
    ]...
  )

  waf_policies  = var.waf_policies
  rule_sets     = var.rule_sets
  origin_groups = var.origin_groups

  flattened_rules = flatten([
    for rs_key, rs in local.rule_sets : [
      for rule_key, rule in rs.rules : {
        ruleset_key = rs_key
        rule_name   = rule_key
        rule_config = rule
      }
    ]
  ])

  flattened_origins = flatten([
    for group_key, group in local.origin_groups : [
      for origin_key, origin in group.origins : {
        group_key   = group_key
        group_name  = group.name
        origin_name = origin_key
        config      = origin
        pls         = origin.private_link_service
      }
    ]
  ])

  flattened_security_associations = flatten([
    for waf_key, waf in local.waf_policies : [
      {
        waf_key           = waf_key
        domain_name       = waf.domain_name
        patterns_to_match = waf.patterns
      }
    ]
  ])


  custom_domains_config = {
    for domain_key, domain in var.custom_domains : domain_key => {
      name                     = domain.cert_name
      secret_name              = domain.cert_name
      certificate_version      = domain.certificate_version
      key_vault_name           = domain.key_vault_name
      host_name                = domain.host_name
      key_vault_certificate_id = "https://${domain.key_vault_name}.vault.azure.net/secrets/${domain.cert_name}/${domain.certificate_version}"
    }
  }

  route_resource_ids_by_domain = {
    for domain_key, domain_value in var.custom_domains :
    domain_key => [
      for route_key in domain_value.association :
      azurerm_cdn_frontdoor_route.routes[route_key].id
      if contains(keys(azurerm_cdn_frontdoor_route.routes), route_key)
    ]
  }
}
