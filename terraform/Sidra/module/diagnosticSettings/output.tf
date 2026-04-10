output "diagnosticSettingName" {
  description = "The name of the Diagnostic Setting"
  value       = azurerm_monitor_diagnostic_setting.dignsoticSetting.name
}
output "diagnosticSettingId" {
  description = "The ID of the Diagnostic Setting"
  value       = azurerm_monitor_diagnostic_setting.dignsoticSetting.id
}