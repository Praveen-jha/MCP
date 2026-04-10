# #Local Block for Resource Naming Conventions
locals {
  base_name1 = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  #   application_insights_name = "appi-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  app_service_plan_name = "asp-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  function_app_name     = "webapp-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}av"
  base_name1_clean = replace(lower(join("", [
    var.name_config.short_name,
    var.name_config.product_name,
    var.name_config.environment
  ])), "[^a-z0-9]", "")

  # Build the raw name, then truncate to 24 chars max
  storage_account_name_raw           = "st${local.base_name1_clean}${lower(var.name_config.region_flag)}${var.name_config.instance}"
  storage_account_name               = substr(local.storage_account_name_raw, 0, 24)
  function_app_private_endpoint_name = "pep-${lower(local.function_app_name)}"
  private_service_connection_name    = "psc-${lower(local.function_app_name)}"
  private_dns_zone_group_name        = "pdnsg-${lower(local.function_app_name)}"
  subresource_names                  = ["sites"]


}
