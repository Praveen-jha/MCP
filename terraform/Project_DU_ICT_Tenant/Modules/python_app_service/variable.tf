# The name of the resource group where the App Service resources will be deployed.
variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the Azure Resource Group for deploying the App Service resources."
}

# Specifies the Azure region where the resources will be deployed.
variable "location" {
  type        = string
  description = "The Azure region (e.g., 'East US', 'West Europe') where the resources will be deployed."
}

# The name of the App Service Plan for the Python application.
variable "python_app_service_plan_name" {
  type        = string
  description = "The name of the App Service Plan associated with the Python application."
}

# The name of the App Service hosting the Python application.
variable "python_app_service_name" {
  type        = string
  description = "The name of the App Service where the pyhton application will be deployed."
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

# Specifies the ID of the subnet where the Python application will be deployed.
# Used to configure network settings for the App Service or other resources within this subnet.
variable "python_app_subnet_id" {
  type        = string
  description = "The ID of the subnet designated for deploying the Python application within the virtual network."
}

#Https traffic option for the App Service
variable "https_only" {
  type = bool
  description = "Allowing Https traffic only for the App services"
}

#Minimum TLS version for App Service
variable "minimum_tls_version" {
  type = string
  description = "Minimum TLS Version for the APP Service"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Determines if public network access is enabled (true) or disabled (false) for the resource"
}

# Variable to store the Application Insights instrumentation key
variable "application_insights_instrumentation_key" {
  type        = string
  description = "The instrumentation key for connecting to Azure Application Insights for telemetry data."
}

# Variable to store the Application Insights connection string
variable "application_insights_connection_string" {
  type        = string
  description = "The connection string for Azure Application Insights, allowing full telemetry connectivity and functionality."
}

# Variable to enable or disable route-all setting on a virtual network (VNet)
variable "vnet_route_all_enabled" {
  type        = string
  description = "Indicates whether the 'route all' setting is enabled on the virtual network (VNet). Use 'true' to enable, 'false' to disable."
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of identity to be used. Options include 'SystemAssigned', 'UserAssigned', or 'None'."
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

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

variable "SCM_DO_BUILD_DURING_DEPLOYMENT" {
  type        = string
  description = "Indicates whether a build should occur during deployment."
}

variable "identity_ids" {
  description = "The list of identity IDs"
  type        = list(string)
}

variable "OPENAI_API_KEY" {
  description = "The OpenAI Key for Azure OpenAI Service"
  type = string
}

# variable "allowed_origins" {
#   description = "List of allowed origins for CORS"
#   type        = list(string)
# }

# variable "support_credentials" {
#   description = "Boolean flag to support credentials in CORS"
#   type        = bool
# }
