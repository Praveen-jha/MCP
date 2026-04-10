resource "azurerm_resource_group" "rg" {
  count    = var.resource_group_name == "" ? 1 : 0
  name     = local.resource_group_name
  location = var.region
}

module "azure-front-door" {
  source     = "../Modules/azure-front-door"
  depends_on = [data.azurerm_resource_group.rg]

  existing_frontdoor      = var.existing_frontdoor
  cdn_fd_name             = var.cdn_fd_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.region
  endpoint_name           = var.endpoint_name
  front_door_sku_name     = var.front_door_sku_name

  use_existing_origin_group = var.use_existing_origin_group
  use_existing_rulesets     = var.use_existing_rulesets
  use_existing_waf_policy   = var.use_existing_waf_policy
  use_existing_certificate  = var.use_existing_certificate
  use_existing_secret       = var.use_existing_secret
  origin_groups             = var.origin_groups
  routes                    = var.routes
  custom_domains            = var.custom_domains
  waf_policies              = var.waf_policies
  rule_sets                 = var.rule_sets
}
