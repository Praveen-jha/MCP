// variables.tf
// This file defines the input variables for the azurerm_windows_web_app module.

variable "windows_web_app_name" {
  description = "The name of the Windows Web App."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Windows Web App should exist."
  type        = string
}

variable "location" {
  description = "The Azure Region where the Windows Web App should exist."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the Service Plan that this Windows App Service will be created in."
  type        = string
}

variable "app_settings" {
  description = "A map of App Settings to apply to the Windows Web App."
  type        = map(string)
  default     = null
}

variable "https_only" {
  description = "Can the App Service only be accessed via HTTPS?"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Is Public Network Access enabled for the Windows Web App."
  type        = bool
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "The ID of the Virtual Network Subnet where this Windows Web App should be integrated."
  type        = string
  default     = null
}

variable "site_config" {
  description = "A site_config block as defined below."
  type = object({
    ftps_state             = optional(string) //(Optional) The State of FTP / FTPS service. Possible values include: AllAllowed, FtpsOnly, Disabled.
    minimum_tls_version    = optional(string) //(Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
    use_32_bit_worker      = optional(bool)   //(Optional) Should the Windows Web App use a 32-bit worker. Defaults to true.
    vnet_route_all_enabled = optional(bool)   //(Optional) Should all outbound traffic to have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
    worker_count           = optional(number) //(Optional) The number of Workers for this Windows App Service.

    application_stack = optional(list(object({
      dotnet_version               = optional(string) //(Optional) The version of .NET to use when current_stack is set to dotnet. Possible values include v2.0,v3.0, v4.0, v5.0, v6.0 and v7.0.
      current_stack                = optional(string) //(Optional) The Application Stack for the Windows Web App. Possible values include dotnet, dotnetcore, node, python, php, and java.
      dotnet_core_version          = optional(string) //(Optional) The version of .NET to use when current_stack is set to dotnetcore. Possible values include v4.0.
      java_embedded_server_enabled = optional(bool)   //(Optional) Should the Java Embedded Server (Java SE) be used to run the app.
      java_version                 = optional(string) //(Optional) The version of Java to use when current_stack is set to java.
      node_version                 = optional(string) //(Optional) The version of node to use when current_stack is set to node. Possible values are ~12, ~14, ~16, and ~18.
      php_version                  = optional(string) //(Optional) The version of PHP to use when current_stack is set to php. Possible values are 7.1, 7.4 and Off.
      python                       = optional(bool)   //(Optional) Specifies whether this is a Python app. Defaults to false.
    })))
  })
}

variable "connection_string" {
  description = "One or more connection_string blocks"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}

variable "backup" {
  description = "A backup block as defined below."
  type = list(object({
    enabled                  = optional(bool)
    name                     = string
    storage_account_url      = string
    retention_period_in_days = optional(number)
    schedule = list(object({
      frequency_interval       = number
      frequency_unit           = string
      retention_period_days    = optional(number)
      keep_at_least_one_backup = optional(bool)
      start_time               = optional(string)
    }))
  }))
  default = []
}

variable "identity" {
  description = "(Optional) Configuration for a Managed Service Identity (MSI). Set to null to disable identity."
  type = list(object({
    type         = string
    identity_ids = optional(list(string))
  }))
  default = []
}

variable "logs" {
  description = "A logs block as defined below."
  type = list(object({
    detailed_error_messages_enabled = optional(bool)
    failed_request_tracing_enabled  = optional(bool)

    application_logs = optional(list(object({
      file_system_level = string
      azure_blob_storage = optional(list(object({
        level             = string
        retention_in_days = number
        sas_url           = string
      })))
    })))

    http_logs = optional(list(object({
      file_system = optional(list(object({
        retention_in_days = number
        retention_in_mb   = number
      })))
      azure_blob_storage = optional(list(object({
        retention_in_days = number
        sas_url           = string
      })))
    })))
  }))
  default = []
}

variable "storage_accounts" {
  description = "A list of storage account configurations."
  type = list(object({
    access_key   = string
    account_name = string
    mount_path   = string
    name         = string
    share_name   = string
    type         = string
  }))
  default = []
}
