# #Local Block for Resource Naming Conventions
locals {
  base_name1                   = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"
  base_name1_clean             = replace(local.base_name1, "-", "")
  event_grid_system_topic_name = "egst-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}av"
  eventgrid_subscriptions_name = "egst-sub-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}a"
  storage_account_name         = "${local.base_name1}${var.name_config.region_flag}str${var.name_config.instance}"
  storage_queue_name           = "${local.base_name1}-${var.name_config.region_flag}-queue-${var.name_config.instance}"
}