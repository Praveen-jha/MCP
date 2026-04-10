#Local Block for Resource Naming Conventions
locals {
  resource_group_name = var.name_config.web_app_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_web_app[0].name

  base_name1 = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  application_insights_name = "appi-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  app_service_plan_name     = "asp-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  windows_web_app_name      = "webapp-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}av"

  all_web_apps = flatten([
    for plan_name, plan_details in var.app_service_mapping : [
      for web_app_obj in plan_details.web_apps : {
        app_service_plan_name           = plan_name
        web_app_name                    = web_app_obj.name
        web_app_private_endpoint_name   = "pep-${lower(web_app_obj.name)}-${lower(plan_name)}"
        private_service_connection_name = "psc-${lower(web_app_obj.name)}-${lower(plan_name)}"
        private_dns_zone_group_name     = "pdnsg-${lower(web_app_obj.name)}-${lower(plan_name)}"
        subresource_names               = ["sites"]
        web_app_site_config             = lookup(web_app_obj, "site_config", {})
        web_app_app_settings            = lookup(web_app_obj, "app_settings", {})
        web_app_slots                   = lookup(web_app_obj, "web_app_slots", {})
      }
    ]
  ])

  web_apps_for_each = {
    for web_app_obj in local.all_web_apps :
    "${web_app_obj.app_service_plan_name}-${web_app_obj.web_app_name}" => web_app_obj
  }

  web_app_slots_for_each = {
    for slot_item in flatten([                                  # Flatten the list of lists into a single list of slot objects
      for web_app_key, web_app_obj in local.web_apps_for_each : # Outer loop over web apps
      [
        for slot_obj in web_app_obj.web_app_slots : # Inner loop over slots for each web app
        {                                           # Create an object for each slot
          parent_web_app_key                 = web_app_key
          slot_name                          = slot_obj.name
          slot_site_config                   = lookup(slot_obj, "slot_site_config", {})
          slot_public_network_access_enabled = lookup(slot_obj, "slot_public_network_access_enabled", null)
          slot_vnet_integration_enable       = lookup(slot_obj, "slot_vnet_integration_enable", null)
          enable_application_insights        = lookup(slot_obj, "enable_application_insights", null)
          slot_app_settings                  = lookup(slot_obj, "slot_app_settings", {})
        }
      ]                                                                   # The inner 'for' results in a list of slot objects
    ]) :                                                                  # Now, 'slot_item' is one of those slot objects
    "${slot_item.parent_web_app_key}-${slot_item.slot_name}" => slot_item # Construct the final map entry
  }

  private_endpoints_for_each = var.public_network_access_enabled ? {} : local.web_apps_for_each

}
