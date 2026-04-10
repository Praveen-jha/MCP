#Variables for Monitor Metric Alert module main file
variable "resource_name" {
  description = "The name of the Azure Monitor Metric Alert."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the metric alert will be created."
  type        = string
}

variable "alert_name" {
  type        = string
  description = "Name of Alert."
}

variable "scopes_ids" {
  description = "The ID of the Azure Firewall to monitor."
  type        = list(string)
}

variable "alert_description" {
  description = "Description of the metric alert."
  type        = string
}

variable "alert_severity" {
  description = "The severity level of the alert (1 = Critical, 2 = Error, 3 = Warning, 4 = Informational, 5 = Verbose)."
  type        = number
  default     = 2
}

variable "alert_frequency" {
  description = "The frequency at which the alert will be evaluated."
  type        = string
  default     = "PT1M"
}

variable "alert_window_size" {
  description = "The size of the time window over which data is aggregated for alert evaluation."
  type        = string
  default     = "PT5M"
}

variable "alert_enabled" {
  description = "Whether the metric alert is enabled."
  type        = bool
  default     = true
}

variable "action_group_id" {
  description = "List of Azure Monitor Action Group IDs to notify when an alert is triggered."
  type        = string
}

variable "metric_criteria" {
  description = "A map of metric criteria where keys are metric names and values contain the alert parameters."
  type = map(object({
    metric_namespace = string //(Required) One of the metric namespaces to be monitored.
    aggregation      = string //(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total.
    threshold        = string //(Required) The criteria threshold value that activates the alert.
    operator         = string //(Required) The criteria operator. Possible values are Equals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual.
  }))
}
