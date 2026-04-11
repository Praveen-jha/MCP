data "azurerm_resource_group" "data_rg" {
  name = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
}