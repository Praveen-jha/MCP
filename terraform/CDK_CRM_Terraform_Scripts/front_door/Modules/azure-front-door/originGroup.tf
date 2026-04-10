resource "azurerm_cdn_frontdoor_origin_group" "origin_group" {
  for_each = var.use_existing_origin_group ? {} : local.origin_groups

  name                     = each.value.name
  cdn_frontdoor_profile_id = local.front_door_profile_id
  session_affinity_enabled = true

  load_balancing {
    sample_size                 = each.value.load_balancing.sample_size
    successful_samples_required = each.value.load_balancing.successful_samples_required
  }

  health_probe {
    path                = each.value.health_probe.path
    request_type        = each.value.health_probe.request_type
    protocol            = each.value.health_probe.protocol
    interval_in_seconds = each.value.health_probe.interval_in_seconds
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin" {
  for_each = {
    for item in local.flattened_origins : "${item.group_key}-${item.origin_name}" => item
  }

  name                          = each.value.origin_name
  cdn_frontdoor_origin_group_id = var.use_existing_origin_group ? data.azurerm_cdn_frontdoor_origin_group.existing[each.value.group_key].id : azurerm_cdn_frontdoor_origin_group.origin_group[each.value.group_key].id
  dynamic "private_link" {
    for_each = each.value.pls != null ? [1] : []
    content {
      target_type            = each.value.pls.private_link_target_type
      location               = each.value.pls.private_link_location
      private_link_target_id = each.value.pls.private_link_target_id
      request_message        = each.value.pls.private_link_request_message
    }
  }
  enabled                        = each.value.config.enabled
  host_name                      = each.value.config.host_name
  http_port                      = each.value.config.http_port
  https_port                     = each.value.config.https_port
  origin_host_header             = each.value.config.origin_host_header
  priority                       = each.value.config.priority
  weight                         = each.value.config.weight
  certificate_name_check_enabled = each.value.config.certificate_name_check_enabled
}

