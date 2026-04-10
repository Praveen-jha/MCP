locals {
  monitor_resource_group_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-monitoring-rg"
  law_name                    = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-law"
}