variable "autoscale_setting_name" {
  description = "The name of the autoscale setting."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the autoscale setting."
  type        = string
}

variable "location" {
  description = "The location of the autoscale setting."
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the resource to be scaled (e.g., App Service Plan)."
  type        = string
}

variable "autoscale_min_capacity" {
  description = "The minimum number of instances for autoscaling."
  type        = number
}

variable "autoscale_max_capacity" {
  description = "The maximum number of instances for autoscaling."
  type        = number
}

variable "autoscale_default_capacity" {
  description = "The default number of instances for autoscaling."
  type        = number
}

variable "cpu_metric_name" {
  description = "The name of the metric to monitor."
  type        = string
}

variable "cpu_metric_threshold_increase" {
  description = "The CPU percentage threshold to increase instances."
  type        = number
}

variable "cpu_metric_threshold_decrease" {
  description = "The CPU percentage threshold to decrease instances."
  type        = number
}

variable "statistic" {
  description = "The statistic type to monitor (e.g., Average)."
  type        = string
}

variable "operator_increase" {
  description = "The comparison operator for increasing scale actions."
  type        = string
}

variable "operator_decrease" {
  description = "The comparison operator for decreasing scale actions."
  type        = string
}

variable "time_aggregation" {
  description = "The time aggregation method."
  type        = string
}

variable "time_grain" {
  description = "The granularity of the metric trigger."
  type        = string
}

variable "time_window" {
  description = "The time window for the metric trigger."
  type        = string
}

variable "increase_scale_action_change_count" {
  description = "The number of instances to add or remove during scaling actions."
  type        = number
}

variable "decrease_scale_action_change_count" {
  description = "The number of instances to add or remove during scaling actions."
  type        = number
}

variable "scale_action_cooldown" {
  description = "The cooldown period after a scaling action."
  type        = string
}
