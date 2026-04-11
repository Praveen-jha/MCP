# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

# Variable for the Business unit name
variable "bu_name" {
  type        = string
  description = "The name of the Business unit."
}

# Specifies the SKU for the App Service Plan (pricing tier). Default is 'S1' for Standard.
variable "node_app_service_plan_sku" {
  type        = string
  description = "The pricing tier SKU for the App Service Plan. Default is 'S1' for Standard tier."
}

# Specifies the OS type for the App Service Plan. Default is 'Windows'.
variable "node_app_service_plan_os_type" {
  type        = string
  description = "The operating system type for the App Service Plan, such as 'Windows' or 'Linux'. Default is 'Windows'."
}

# Defines the Node.js version to be used for the application.
variable "node_version" {
  type        = string
  description = "The version of Node.js to be used for the application deployment."
}

# Specifies the SKU for the App Service Plan (pricing tier). Default is 'S1' for Standard.
variable "python_app_service_plan_sku" {
  type        = string
  description = "The pricing tier SKU for the App Service Plan. Default is 'S1' for Standard tier."
}

# Specifies the OS type for the App Service Plan. Default is 'Windows'.
variable "python_app_service_plan_os_type" {
  type        = string
  description = "The operating system type for the App Service Plan, such as 'Windows' or 'Linux'. Default is 'Windows'."
}

# Defines the pythonversion to be used for the application.
variable "python_version" {
  type        = string
  description = "The version of python to be used for the application deployment."
}

# The name of the virtual network containing the subnet.
variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network containing the subnet."
}

# The name of the resource group where the virtual network and subnet reside.
variable "subnet_resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual network and subnet are located."
}

# Specifies the name of the subnet designated for the Python application.
# Used to identify the subnet where network resources for the Python application will be deployed.
variable "python_as_subnet_name" {
  type        = string
  description = "The name of the subnet assigned to host the Python application within the virtual network."
}

variable "current_stack" {
  type        = string
  description = "Defines the current application stack"
}

#Https traffic options for App Service
variable "https_only" {
  type = bool
  description = "Allowing Https traffic only for the App services"
}

#Minimum TLS version for App Service
variable "minimum_tls_version" {
  type = string
  description = "Minimum TLS Version for the APP Service"
}

variable "log_analytics_workspace_id" {
  type = string
  default = "ID of centralised Log Analytics workspace"
}

# Variable to specify the type of application being deployed
variable "application_type" {
  type        = string
  description = "The type of application (e.g., 'web', 'api', 'function') to define its configuration or monitoring setup."
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of identity to be used. Options include 'SystemAssigned', 'UserAssigned', or 'None'."
}

# Use this variable to define tags for resources associated with the Node.js application.
variable "node_app_tags" {
  type        = map(string)
  description = "A map of key-value pairs to tag resources related to the Node.js application."
}

# Use this variable to define tags for resources associated with the Python application.
variable "python_app_tags" {
  type        = map(string)
  description = "A map of key-value pairs to tag resources related to the Python application."
}

# Variables related to Application Insights features and extensions
variable "appinsights_profilerfeature_version" {
  type        = string
  description = "Version for the Application Insights Profiler feature."
}

variable "appinsights_snapshotfeature_version" {
  description = "Version for the Application Insights Snapshot feature."
  type        = string
}

variable "applicationinsightsagent_extension_version" {
  description = "Version for the Application Insights Agent extension."
  type        = string
}

variable "diagnosticservices_extension_version" {
  description = "Version for the Diagnostic Services extension."
  type        = string
}

variable "instrumentationengine_extension_version" {
  description = "Version for the Instrumentation Engine extension."
  type        = string
}

variable "snapshotdebugger_extension_version" {
  description = "Version for the Snapshot Debugger extension."
  type        = string
}

variable "xdt_microsoftapplicationinsights_baseextensions" {
  description = "Enable base extensions for Microsoft Application Insights."
  type        = string
}

variable "xdt_microsoftapplicationinsights_mode" {
  description = "Mode for Microsoft Application Insights."
  type        = string
}

# Deployment-related settings
variable "SCM_DO_BUILD_DURING_DEPLOYMENT" {
  type        = string
  description = "Indicates whether a build should occur during deployment."
}

# Identity and resource group details
variable "uaid_name" {
  type = string
  description = "Name of the User assigned Identity."
}

variable "data_resource_group_name" {
  description = "The name of the resource group containing the Key Vault."
  type        = string
}

# Budget configuration variables
variable "amount" {
  description = "The amount of the budget."
  type        = number
}

variable "timeGrain" {
  description = "The time grain for budget evaluation (e.g., Monthly, Quarterly)."
  type        = string
}

variable "startDate" {
  description = "The start date for the budget period."
  type        = string
}

variable "endDate" {
  description = "The end date for the budget period."
  type        = string
}

# Environment variable for Node.js application
variable "REACT_APP_API_URL" {
  type = string
  description = "Node App service URL."
}

# OpenAI API key configuration
variable "OPENAI_API_KEY" {
  type = string
  description = "OpenAI Keys to be declared here."
}

# Autoscaling settings for Node.js application
variable "node_autoscale_min_capacity" {
  description = "The minimum number of instances for autoscaling."
  type        = number
}

# Autoscaling configuration for the Node.js application
# Maximum number of instances allowed for autoscaling
variable "node_autoscale_max_capacity" {
  description = "The maximum number of instances for autoscaling."
  type        = number
}

# Default number of instances when no scaling action is triggered
variable "node_autoscale_default_capacity" {
  description = "The default number of instances for autoscaling."
  type        = number
}

# CPU threshold percentage to trigger scaling up (adding instances)
variable "node_cpu_metric_threshold_increase" {
  description = "The CPU percentage threshold to increase instances."
  type        = number
}

# CPU threshold percentage to trigger scaling down (removing instances)
variable "node_cpu_metric_threshold_decrease" {
  description = "The CPU percentage threshold to decrease instances."
  type        = number
}

# Type of metric statistic to monitor (e.g., Average, Minimum, Maximum)
variable "node_statistic" {
  description = "The statistic type to monitor (e.g., Average)."
  type        = string
}

# Comparison operator to determine when to increase scale actions
variable "node_operator_increase" {
  description = "The comparison operator for increasing scale actions."
  type        = string
}

# Comparison operator to determine when to decrease scale actions
variable "node_operator_decrease" {
  description = "The comparison operator for decreasing scale actions."
  type        = string
}

# Time aggregation method for metric evaluation (e.g., Average, Sum, Count)
variable "node_time_aggregation" {
  description = "The time aggregation method."
  type        = string
}

# Granularity of the metric trigger (e.g., 1 minute, 5 minutes)
variable "node_time_grain" {
  description = "The granularity of the metric trigger."
  type        = string
}

# Time window during which metrics are evaluated for scaling actions
variable "node_time_window" {
  description = "The time window for the metric trigger."
  type        = string
}

# Number of instances to remove during a scale-down action
variable "node_decrease_scale_action_change_count" {
  description = "The number of instances to add or remove during scaling actions."
  type        = number
}

# Number of instances to add during a scale-up action
variable "node_increase_scale_action_change_count" {
  description = "The number of instances to add or remove during scaling actions."
  type        = number
}

# Cooldown period after a scaling action to prevent rapid successive actions
variable "node_scale_action_cooldown" {
  description = "The cooldown period after a scaling action."
  type        = string
}

# Autoscaling settings for Python application
variable "py_autoscale_min_capacity" {
  description = "The minimum number of instances for autoscaling."
  type        = number
}

# Autoscaling configuration for the Python application
# Maximum number of instances allowed for autoscaling
variable "py_autoscale_max_capacity" {
  description = "The maximum number of instances for autoscaling."
  type        = number
}

# Default number of instances when no scaling action is triggered
variable "py_autoscale_default_capacity" {
  description = "The default number of instances for autoscaling."
  type        = number
}

# CPU threshold percentage to trigger scaling up (adding instances)
variable "py_cpu_metric_threshold_increase" {
  description = "The CPU percentage threshold to increase instances."
  type        = number
}

# CPU threshold percentage to trigger scaling down (removing instances)
variable "py_cpu_metric_threshold_decrease" {
  description = "The CPU percentage threshold to decrease instances."
  type        = number
}

# Type of metric statistic to monitor (e.g., Average, Minimum, Maximum)
variable "py_statistic" {
  description = "The statistic type to monitor (e.g., Average)."
  type        = string
}

# Comparison operator to determine when to increase scale actions
variable "py_operator_increase" {
  description = "The comparison operator for increasing scale actions."
  type        = string
}

# Comparison operator to determine when to decrease scale actions
variable "py_operator_decrease" {
  description = "The comparison operator for decreasing scale actions."
  type        = string
}

# Time aggregation method for metric evaluation (e.g., Average, Sum, Count)
variable "py_time_aggregation" {
  description = "The time aggregation method."
  type        = string
}

# Granularity of the metric trigger (e.g., 1 minute, 5 minutes)
variable "py_time_grain" {
  description = "The granularity of the metric trigger."
  type        = string
}

# Time window during which metrics are evaluated for scaling actions
variable "py_time_window" {
  description = "The time window for the metric trigger."
  type        = string
}

# Number of instances to remove during a scale-down action
variable "py_decrease_scale_action_change_count" {
  description = "The number of instances to add or remove during scaling actions."
  type        = number
}

# Number of instances to add during a scale-up action
variable "py_increase_scale_action_change_count" {
  description = "The number of instances to add or remove during scaling actions."
  type        = number
}

# Cooldown period after a scaling action to prevent rapid successive actions
variable "py_scale_action_cooldown" {
  description = "The cooldown period after a scaling action."
  type        = string
}
