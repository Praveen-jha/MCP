locals {
  application_rg_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-app-rg"
  logic_app_name      = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-logic-app"
  diagnostic_setting_name = "logicAppDiagnosticLogsToWorkspace"
  log_category = {
    category        = [],
    category_groups = ["allLogs"]
  }
  metrics = ["AllMetrics"]
}