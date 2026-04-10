locals {
  resource_group_name = var.rg_creation == "new" ? module.RG.resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.RG.resource_group_location : data.azurerm_resource_group.resource_group[0].location

  log_workspace_name = "${var.tenant_name}-platform-hrbot-${var.environment}-law"
  LA_rg_name         = "${var.tenant_name}-platform-hrbot-${var.environment}-monitor-rg"

}
