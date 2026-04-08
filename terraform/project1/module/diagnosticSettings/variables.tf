variable "dignosticSettingName" {
  description = "The name of the Diagnostics Setting"
  type        = string
}
variable "targetResourceId" {
  description = "The ID of the target resource on which, the Diagnostic Settings will be configured"
  type        = string
}
variable "enabledLogs" {
  description = "List of categories for enabled logs"
  type        = list(string)
  default = [ "allLogs" ]
}
variable "metric" {
  description = "List of categories for metrics"
  type        = list(string)
}
variable "logAnalyticsWorkspaceId" {
  description = "Log analytics workspace id where the Diagnostics Data will go"
  type        = string
}