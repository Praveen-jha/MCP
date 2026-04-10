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

# Specifies the name of the subnet designated for the Node.js application.
# Used to identify the subnet where network resources for the Node.js application will be deployed.
variable "node_as_subnet_name" {
  type        = string
  description = "The name of the subnet assigned to host the Node.js application within the virtual network."
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

# Https traffic options for App Service
variable "https_only" {
  type = bool
  description = "Allowing Https traffic only for the App services"
}

# Minimum TLS version for App Service
variable "minimum_tls_version" {
  type = string
  description = "Minimum TLS Version for the APP Service"
}

# ID of centralised Log Analytics workspace
variable "log_analytics_workspace_id" {
  type = string
  default = "ID of centralised Log Analytics workspace"
}

# Variable to specify the type of application being deployed
variable "application_type" {
  type        = string
  description = "The type of application (e.g., 'web', 'api', 'function') to define its configuration or monitoring setup."
}

# Specifies the type of identity to be used. Options include 'SystemAssigned', 'UserAssigned', or 'None'.
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

# Version for the Application Insights Profiler feature
variable "appinsights_profilerfeature_version" {
  type        = string
  description = "Specifies the version for the Application Insights Profiler feature used to analyze application performance."
}

# Version for the Application Insights Snapshot feature
variable "appinsights_snapshotfeature_version" {
  type        = string
  description = "Specifies the version for the Application Insights Snapshot feature used to capture snapshots during exceptions."
}

# Version for the Application Insights Agent extension
variable "applicationinsightsagent_extension_version" {
  type        = string
  description = "Specifies the version for the Application Insights Agent extension, responsible for telemetry collection."
}

# Version for the Diagnostic Services extension
variable "diagnosticservices_extension_version" {
  type        = string
  description = "Specifies the version for the Diagnostic Services extension used for debugging and diagnostics."
}

# Version for the Instrumentation Engine extension
variable "instrumentationengine_extension_version" {
  type        = string
  description = "Specifies the version for the Instrumentation Engine extension used for collecting telemetry data."
}

# Version for the Snapshot Debugger extension
variable "snapshotdebugger_extension_version" {
  type        = string
  description = "Specifies the version for the Snapshot Debugger extension, enabling real-time debugging of production applications."
}

# Enable base extensions for Microsoft Application Insights
variable "xdt_microsoftapplicationinsights_baseextensions" {
  type        = string
  description = "Enables or disables the base extensions for Microsoft Application Insights. Provide the value as a string."
}

# Mode for Microsoft Application Insights
variable "xdt_microsoftapplicationinsights_mode" {
  type        = string
  description = "Specifies the operational mode for Microsoft Application Insights (e.g., Application Monitoring)."
}

# Build during deployment setting
variable "SCM_DO_BUILD_DURING_DEPLOYMENT" {
  type        = string
  description = "Indicates whether the application should build during deployment. Typically 'true' or 'false'."
}

# Node application service URL
variable "REACT_APP_API_URL" {
  type        = string
  description = "The base URL for the Node.js application service."
}

# OpenAI API Key
variable "OPENAI_API_KEY" {
  type        = string
  description = "The API key for accessing OpenAI services."
}

# Use this variable to define tags for resources associated with the Node.js application.
variable "node_app_uat_tags" {
  type        = map(string)
  description = "A map of key-value pairs to tag resources related to the Node.js application."
}

# Use this variable to define tags for resources associated with the Python application.
variable "python_app_uat_tags" {
  type        = map(string)
  description = "A map of key-value pairs to tag resources related to the Python application."
}

# Name of the User Assigned Identity (UAID) for resource authentication
variable "uaid_name" {
  description = "Name of the User Assigned Identity."
  type        = string
}

# Name of the resource group containing the Key Vault
variable "data_resource_group_name" {
  description = "The name of the resource group containing the Key Vault."
  type        = string
}
