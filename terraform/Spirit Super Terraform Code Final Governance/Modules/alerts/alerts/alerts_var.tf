variable "alert_name" {
  type        = string
  description = "(Required) The name of the Metric Alert."
}

variable "scope" {
  type        = string
  description = "v(Required) A set of strings of resource IDs at which the metric criteria should be applied."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Metric Alert instance."
}

variable "description" {
  type        = string
  description = "(Optional) The description of this Metric Alert."
}

variable "metric_name" {
  type        = string
  description = "(Required) One of the metric names to be monitored."
}

variable "metric_namespace" {
  type        = string
  description = "(Required) One of the metric namespaces to be monitored."
}

variable "aggregation" {
  type        = string
  description = "(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total."
}

variable "operator" {
  type        = string
  description = "(Required) The criteria operator. Possible values are LessThan, GreaterThan and GreaterOrLessThan."
}

variable "threshold" {
  type        = string
  description = "(Required) The criteria threshold value that activates the alert."
}

variable "action_group_id" {
  type        = string
  description = "(Required) The ID of the Action Group."
}

variable "frequency" {
  type        = string
  description = "(Optional) The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M."
}

variable "window_size" {
  type        = string
  description = "(Optional) The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M."
}
