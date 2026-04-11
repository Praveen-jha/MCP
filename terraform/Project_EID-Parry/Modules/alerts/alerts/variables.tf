# Variables for Hub Network Workload
variable "nameConfig" {
  type = object({
    defaultLocation = string      //Location for the Resource to be Deployed.
    rg_creation     = string      //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    businessunit    = string      //Workload type of the resource
    identity        = string      //Flag to use in Naming Convention
  })
}

variable "hub_resource_group_name" {
  type        = string
  description = "Name of Hub Resource Group."
}

variable "non_prod_resource_group_name" {
  type        = string
  description = "Name of Non Prod Resource Group."
}

variable "prod_resource_group_name" {
  type        = string
  description = "Name of Prod Resource Group."
}

variable "hub_sha_virtual_machine_name" {
  type        = string
  description = "Name of Hub SHA Virtual Machine."
}

variable "non_prod_shir_virtual_machine_name" {
  type        = string
  description = "Name of Non Prod SHIR Virtual Machine."
}

variable "non_prod_odgw_virtual_machine_name" {
  type        = string
  description = "Name of Non Prod ODGW Virtual Machine."
}

variable "prod_shir_virtual_machine_name" {
  type        = string
  description = "Name of Prod SHIR Virtual Machine."
}

variable "prod_odgw_virtual_machine_name" {
  type        = string
  description = "Name of Prod ODGW Virtual Machine."
}

variable "virtual_network_gateway_name" {
  type        = string
  description = "Name of the Virtual Network Gateway."
}

variable "non_prod_data_factory_name" {
  type        = string
  description = "Name of the Non Prod Data Factory."
}

variable "prod_data_factory_name" {
  type        = string
  description = "Name of the Prod Data Factory."
}

variable "action_group_details" {
  type = object({
    short_name    = string      //Short name for the Action Group.
    email_details = map(string) //A map of email receivers for the action group.
  })
  default = {
    short_name = "vm-metrics"
    email_details = {
      "Ekta Jarwal" = ""
    }
  }
  description = "Details of the Action Group including Short Name and Email Details."
}

variable "vm_alerts_details" {
  type = object({
    alert_severity    = number //The severity level of the alert. (1 = Critical, 2 = Error, 3 = Warning, 4 = Informational, 5 = Verbose)
    alert_frequency   = string //The frequency at which the alert will be evaluated.
    alert_description = string //Monitoring Virtual Machine Metrics.
    alert_window_size = string //The size of the time window over which data is aggregated for alert evaluation.
    alert_enabled     = bool   //Boolean to enable or disable the metric alert.
  })
  description = "Details of Virtual Machine Alerts including Severity, Frequency, Description, Window Size."
}

variable "vm_metric_criteria" {
  description = "A map of metric criteria where keys are metric names and values contain the alert parameters."
  type = map(object({
    metric_namespace = string //(Required) One of the metric namespaces to be monitored.
    aggregation      = string //(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total.
    threshold        = string //(Required) The criteria threshold value that activates the alert.
    operator         = string //(Required) The criteria operator. Possible values are Equals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual.
  }))
}

variable "vpn_alerts_details" {
  type = object({
    alert_severity    = number //The severity level of the alert. (1 = Critical, 2 = Error, 3 = Warning, 4 = Informational, 5 = Verbose)
    alert_frequency   = string //The frequency at which the alert will be evaluated.
    alert_description = string //Monitoring Virtual Machine Metrics.
    alert_window_size = string //The size of the time window over which data is aggregated for alert evaluation.
    alert_enabled     = bool   //Boolean to enable or disable the metric alert.
  })
  description = "Details of Virtual Network Gateway Alerts including Severity, Frequency, Description, Window Size."
}

variable "vpn_metric_criteria" {
  description = "A map of metric criteria where keys are metric names and values contain the alert parameters."
  type = map(object({
    metric_namespace = string //(Required) One of the metric namespaces to be monitored.
    aggregation      = string //(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total.
    threshold        = string //(Required) The criteria threshold value that activates the alert.
    operator         = string //(Required) The criteria operator. Possible values are Equals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual.
  }))
}

variable "data_factory_alerts_details" {
  type = object({
    alert_severity    = number //The severity level of the alert. (1 = Critical, 2 = Error, 3 = Warning, 4 = Informational, 5 = Verbose)
    alert_frequency   = string //The frequency at which the alert will be evaluated.
    alert_description = string //Monitoring Virtual Machine Metrics.
    alert_window_size = string //The size of the time window over which data is aggregated for alert evaluation.
    alert_enabled     = bool   //Boolean to enable or disable the metric alert.
  })
  description = "Details of Data Factory Alerts including Severity, Frequency, Description, Window Size."
}

variable "data_factory_metric_criteria" {
  description = "A map of metric criteria where keys are metric names and values contain the alert parameters."
  type = map(object({
    metric_namespace = string //(Required) One of the metric namespaces to be monitored.
    aggregation      = string //(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total.
    threshold        = string //(Required) The criteria threshold value that activates the alert.
    operator         = string //(Required) The criteria operator. Possible values are Equals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual.
  }))
}

variable "budget_amount" {
  description = "The total amount of cost to track for the budget."
  type        = number
}

variable "budget_time_grain" {
  description = "The time grain for the budget. Possible values are 'Annually', 'Monthly', and 'Quarterly'."
  type        = string
}

variable "budget_start_date" {
  description = "The start date for the budget in 'YYYY-MM-DDTHH:MM:SSZ' format."
  type        = string
}

variable "budget_end_date" {
  description = "The end date for the budget in 'YYYY-MM-DDTHH:MM:SSZ' format. Optional."
  type        = string
  default     = null
}

variable "budget_notifications" {
  description = "A list of notification configurations for the budget."
  type = list(object({
    enabled        = bool             # Whether the notification is enabled
    threshold      = number           # The threshold percentage for the notification (e.g., 90.0)
    operator       = string           # The operator for the threshold ('EqualTo', 'GreaterThan', 'GreaterThanOrEqualTo')
    threshold_type = optional(string) # Optional: 'Actual' or 'Forecasted'. Defaults to 'Actual' if not specified by Azure.
    contact_emails = optional(list(string), []) # List of email addresses to notify
    contact_roles  = optional(list(string), []) # List of Azure RBAC roles to notify (e.g., 'Owner', 'Contributor')
  }))
  default = [] # Default to an empty list if no notifications are needed
}