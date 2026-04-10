resource "azurerm_cdn_frontdoor_secret" "fd_secret" {
  for_each = var.use_existing_secret ? {} : local.custom_domains_config

  depends_on = [
    azurerm_role_assignment.fd_secret_user
  ]

  name                     = each.value.name
  cdn_frontdoor_profile_id = local.front_door_profile_id

  secret {
    customer_certificate {
      key_vault_certificate_id = data.azurerm_key_vault_certificate.cert[each.key].id
    }
  }

  lifecycle {
    ignore_changes = [secret]
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "fd_custom_domain" {
  for_each = local.custom_domains_config

  name                     = each.key
  host_name                = each.value.host_name
  cdn_frontdoor_profile_id = local.front_door_profile_id

  tls {
    cdn_frontdoor_secret_id = var.use_existing_secret ? data.azurerm_cdn_frontdoor_secret.fd_secret[each.key].id : azurerm_cdn_frontdoor_secret.fd_secret[each.key].id
    certificate_type        = "CustomerCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "fd_domain_association" {
  for_each = var.custom_domains

  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.fd_custom_domain[each.key].id
  cdn_frontdoor_route_ids        = local.route_resource_ids_by_domain[each.key]
}
