variable "targetResourceId" {
  type        = string
  description = "The ID of the target resource for diagnostic settings."
}

variable "dignosticSettingName" {
  type        = string
  description = "diagnostics setting names"
}

variable "logAnalyticsWorkspaceId" {
  type        = string
  description = "log analytics workspace id"
}
