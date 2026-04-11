variable "diagnostic_setting_name" {
  description = "The name of the diagnostic setting."
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the target resource where diagnostic logs will be collected."
  type        = string
}

variable "enabled_log" {
  description = "The configuration for enabling diagnostic logs."
  type = object({
    category        = list(string)
    category_groups = list(string)
  })
  default = {
    category        = ["value"]
    category_groups = ["value"]
  }
}

variable "metric" {
  description = "The list of metric categories to be monitored."
  type        = list(string)
}

variable "log_analytics_workspace_id" {
  type = string
  default = "ID of centralised Log Analytics workspace"
}
