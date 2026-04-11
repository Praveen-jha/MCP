variable "metric_alert_name" {
  type        = string
  description = "The name of the metric alert to be created."
}

variable "scopes" {
  type        = list(string)
  description = "A list of resource IDs to monitor with the metric alert. Typically includes Azure resource IDs such as web apps or virtual machines."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the metric alert will be created."
}

variable "action_group_id" {
  type        = string
  description = "The ID of the action group that will be triggered by the metric alert."
}

variable "description" {
  type        = string
  description = "A description of the metric alert, detailing its purpose and conditions."
}

variable "criteria_config" {
  type = list(object({
    metric_namespace       = string
    metric_name            = string
    aggregation            = string
    operator               = string
    threshold              = number
    skip_metric_validation = bool
  }))
  description = "A list of criteria configurations for the metric alert."
}
