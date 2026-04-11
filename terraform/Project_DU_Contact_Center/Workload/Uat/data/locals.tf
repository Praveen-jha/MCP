locals {
  location                = var.rg_creation == "new" ? module.RG[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location
  resource_group_name     = var.rg_creation == "new" ? module.RG[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  uat_data_rg_name        = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01" //ict-platform-ccai-uat-data-rg-uaen-01
  apim_name               = "${var.tenant_name}-platform-${var.environment}-apim-${var.location_shortname}-01"                    //ict-platform-ccai-uat-apim-uaen-01"
  container_registry_name = "${var.tenant_name}platformccaiuatacr${var.location_shortname}01"
}
