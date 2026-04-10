# Required Variables
variable "function_app_name" {
  description = "The name of the Function App."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure location for the Function App."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account."
  type        = string
}

# Optional Storage Configuration
variable "storage_account_access_key" {
  description = "The access key for the Storage Account."
  type        = string
  default     = null
}

# variable "storage_key_vault_secret_id" {
#   description = "The Key Vault Secret ID for the Storage Account access key."
#   type        = string
#   default     = null
# }

# variable "storage_uses_managed_identity" {
#   description = "Should the Function App use Managed Identity to access the storage account?"
#   type        = bool
#   default     = false
# }

# Optional Basic Configuration
variable "app_settings" {
  description = "A map of key-value pairs for App Settings."
  type        = map(string)
  default     = {}
}

variable "builtin_logging_enabled" {
  description = "Should built-in logging be enabled?"
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "Should client certificates be enabled?"
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "The mode of the Function App's client certificates requirement."
  type        = string
  default     = "Required"
  validation {
    condition     = contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode)
    error_message = "Valid values are Required, Optional, or OptionalInteractiveUser."
  }
}

variable "client_certificate_exclusion_paths" {
  description = "Paths to exclude from client certificate authentication."
  type        = string
  default     = null
}

variable "daily_memory_time_quota" {
  description = "The amount of memory in gigabyte-seconds that your application is allowed to consume per day."
  type        = number
  default     = 0
}

variable "enabled" {
  description = "Is the Function App enabled?"
  type        = bool
  default     = true
}

variable "ftp_publish_basic_authentication_enabled" {
  description = "Should the default FTP Basic Authentication publishing profile be enabled?"
  type        = bool
  default     = true
}

variable "functions_extension_version" {
  description = "The runtime version associated with the Function App."
  type        = string
  default     = "~4"
}

variable "https_only" {
  description = "Can the Function App only be accessed via HTTPS?"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for the Function App?"
  type        = bool
  default     = true
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "Should the default WebDeploy Basic Authentication publishing credentials be enabled?"
  type        = bool
  default     = true
}

variable "zip_deploy_file" {
  description = "The local path and filename of the Zip packaged application to deploy to this Windows Function App."
  type        = string
  default     = null
}

# Site Configuration
variable "site_config" {
  description = "Site configuration for the Function App."
  type = object({
    always_on                                     = optional(bool, false)
    api_definition_url                           = optional(string)
    api_management_api_id                        = optional(string)
    app_command_line                             = optional(string)
    app_scale_limit                              = optional(number)
    application_insights_connection_string       = optional(string)
    application_insights_key                     = optional(string)
    default_documents                            = optional(list(string))
    elastic_instance_minimum                     = optional(number)
    ftps_state                                   = optional(string, "Disabled")
    health_check_path                            = optional(string)
    health_check_grace_period                    = optional(number)
    http2_enabled                                = optional(bool, false)
    load_balancing_mode                          = optional(string, "LeastRequests")
    managed_pipeline_mode                        = optional(string, "Integrated")
    minimum_tls_version                          = optional(string, "1.2")
    pre_warmed_instance_count                    = optional(number)
    remote_debugging_enabled                     = optional(bool, false)
    remote_debugging_version                     = optional(string)
    runtime_scale_monitoring_enabled             = optional(bool, false)
    scm_minimum_tls_version                      = optional(string, "1.2")
    scm_use_main_ip_restriction                  = optional(bool, false)
    use_32_bit_worker                            = optional(bool, true)
    vnet_route_all_enabled                       = optional(bool, false)
    websockets_enabled                           = optional(bool, false)
    worker_count                                 = optional(number)

    application_stack = optional(object({
      dotnet_version              = optional(string)
      java_version               = optional(string)
      node_version               = optional(string)
      powershell_core_version    = optional(string)
      python_version             = optional(string)
      use_custom_runtime         = optional(bool)
      use_dotnet_isolated_runtime = optional(bool)
    }))

    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool, false)
    }))

    ip_restrictions = optional(list(object({
      action                    = optional(string, "Allow")
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number, 65000)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
    })), [])

    scm_ip_restrictions = optional(list(object({
      action                    = optional(string, "Allow")
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number, 65000)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
    })), [])
  })
  default = {}
}

# Authentication Settings
variable "auth_settings" {
  description = "Authentication settings for the Function App."
  type = object({
    enabled                        = bool
    additional_login_parameters    = optional(map(string))
    allowed_external_redirect_urls = optional(list(string))
    default_provider              = optional(string)
    issuer                        = optional(string)
    runtime_version               = optional(string)
    token_refresh_extension_hours = optional(number, 72)
    token_store_enabled           = optional(bool, false)
    unauthenticated_client_action = optional(string)

    active_directory = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      allowed_audiences          = optional(list(string))
    }))

    facebook = optional(object({
      app_id                  = string
      app_secret              = optional(string)
      app_secret_setting_name = optional(string)
      oauth_scopes            = optional(list(string))
    }))

    github = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))

    google = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))

    microsoft = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))

    twitter = optional(object({
      consumer_key                 = string
      consumer_secret              = optional(string)
      consumer_secret_setting_name = optional(string)
    }))
  })
  default = null
}

# Backup Configuration
variable "backup" {
  description = "Backup configuration for the Function App."
  type = object({
    name                = string
    storage_account_url = string
    enabled             = optional(bool, true)
    schedule = object({
      frequency_interval       = number
      frequency_unit          = string
      keep_at_least_one_backup = optional(bool, true)
      retention_period_days    = optional(number, 30)
      start_time              = optional(string)
    })
  })
  default = null
}

# Connection Strings
variable "connection_strings" {
  description = "Connection strings for the Function App."
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}

# Identity Configuration
variable "identity" {
  description = "Managed identity configuration for the Function App."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

# Sticky Settings
variable "sticky_settings" {
  description = "Sticky settings configuration for the Function App."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

# Tags
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
