# Required variables
variable "name" {
  description = "The name which should be used for this Linux Function App"
  type        = string
}

variable "location" {
  description = "The Azure Region where the Linux Function App should exist"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Linux Function App should exist"
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan within which to create this Function App"
  type        = string
}

variable "storage_account_name" {
  description = "The backend storage account name which will be used by this Function App"
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key which will be used to access the backend storage account for the Function App"
  type        = string
  sensitive   = true
}

# Optional variables
variable "app_settings" {
  description = "A map of key-value pairs for App Settings and custom values"
  type        = map(string)
  default     = {}
}

variable "builtin_logging_enabled" {
  description = "Should built in logging be enabled"
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "Should the function app use Client Certificates"
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "The mode of the Function App's client certificates requirement for incoming requests"
  type        = string
  default     = "Required"
  validation {
    condition     = contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode)
    error_message = "client_certificate_mode must be Required, Optional, or OptionalInteractiveUser."
  }
}

variable "client_certificate_exclusion_paths" {
  description = "Paths to exclude when using client certificates, separated by ;"
  type        = string
  default     = null
}

variable "daily_memory_time_quota" {
  description = "The amount of memory in gigabyte-seconds that your application is allowed to consume per day"
  type        = number
  default     = 0
}

variable "enabled" {
  description = "Is the Linux Function App enabled"
  type        = bool
  default     = true
}

variable "ftp_publish_basic_authentication_enabled" {
  description = "Should the default FTP Basic Authentication publishing profile be enabled"
  type        = bool
  default     = true
}

variable "functions_extension_version" {
  description = "The runtime version associated with the Function App"
  type        = string
  default     = "~4"
}

variable "https_only" {
  description = "Can the Function App only be accessed via HTTPS"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for the Function App"
  type        = bool
  default     = true
}

variable "key_vault_reference_identity_id" {
  description = "The User Assigned Identity ID used for accessing KeyVault secrets"
  type        = string
  default     = null
}

variable "storage_uses_managed_identity" {
  description = "Should the Function App use Managed Identity to access the storage account"
  type        = bool
  default     = false
}

variable "storage_key_vault_secret_id" {
  description = "The Key Vault Secret ID, optionally including version, that contains the Connection String to connect to the storage account for this Function App"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "virtual_network_subnet_id" {
  description = "The subnet id which will be used by this Function App for regional virtual network integration"
  type        = string
  default     = null
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "Should the default WebDeploy Basic Authentication publishing credentials enabled"
  type        = bool
  default     = true
}

variable "zip_deploy_file" {
  description = "The local path and filename of the Zip packaged application to deploy to this Linux Function App"
  type        = string
  default     = null
}

# Complex optional variables
variable "auth_settings" {
  description = "An auth_settings block for the Function App"
  type = object({
    enabled                        = bool
    additional_login_parameters    = optional(map(string))
    allowed_external_redirect_urls = optional(list(string))
    default_provider               = optional(string)
    issuer                         = optional(string)
    runtime_version                = optional(string)
    token_refresh_extension_hours  = optional(number)
    token_store_enabled            = optional(bool)
    unauthenticated_client_action  = optional(string)
    active_directory = optional(object({
      client_id                  = string
      allowed_audiences          = optional(list(string))
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
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

variable "auth_settings_v2" {
  description = "An auth_settings_v2 block for the Function App"
  type = object({
    auth_enabled                            = bool
    runtime_version                         = optional(string)
    config_file_path                        = optional(string)
    require_authentication                  = optional(bool)
    unauthenticated_action                  = optional(string)
    default_provider                        = optional(string)
    excluded_paths                          = optional(list(string))
    require_https                           = optional(bool)
    http_route_api_prefix                   = optional(string)
    forward_proxy_convention                = optional(string)
    forward_proxy_custom_host_header_name   = optional(string)
    forward_proxy_custom_scheme_header_name = optional(string)
    login = optional(object({
      logout_endpoint                   = optional(string)
      token_store_enabled               = optional(bool)
      token_refresh_extension_time      = optional(number)
      token_store_path                  = optional(string)
      token_store_sas_setting_name      = optional(string)
      preserve_url_fragments_for_logins = optional(bool)
      allowed_external_redirect_urls    = optional(list(string))
      cookie_expiration_convention      = optional(string)
      cookie_expiration_time            = optional(string)
      validate_nonce                    = optional(bool)
      nonce_expiration_time             = optional(string)
    }))
    apple_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    }))
    active_directory_v2 = optional(object({
      client_id                            = string
      tenant_auth_endpoint                 = optional(string)
      client_secret_setting_name           = optional(string)
      client_secret_certificate_thumbprint = optional(string)
      jwt_allowed_groups                   = optional(list(string))
      jwt_allowed_client_applications      = optional(list(string))
      www_authentication_disabled          = optional(bool)
      allowed_groups                       = optional(list(string))
      allowed_identities                   = optional(list(string))
      allowed_applications                 = optional(list(string))
      login_parameters                     = optional(map(string))
      allowed_audiences                    = optional(list(string))
    }))
    azure_static_web_app_v2 = optional(object({
      client_id = string
    }))
    custom_oidc_v2 = optional(list(object({
      name                          = string
      client_id                     = string
      openid_configuration_endpoint = string
      name_claim_type               = optional(string)
      scopes                        = optional(list(string))
      client_credential_method      = optional(string)
      client_secret_setting_name    = optional(string)
      authorisation_endpoint        = optional(string)
      token_endpoint                = optional(string)
      issuer_endpoint               = optional(string)
      certification_uri             = optional(string)
    })))
    facebook_v2 = optional(object({
      app_id                  = string
      app_secret_setting_name = string
      graph_api_version       = optional(string)
      login_scopes            = optional(list(string))
    }))
    github_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    }))
    google_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    microsoft_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    twitter_v2 = optional(object({
      consumer_key                 = string
      consumer_secret_setting_name = string
    }))
  })
  default = null
}

variable "backup" {
  description = "A backup block for the Function App"
  type = object({
    name                = string
    storage_account_url = string
    enabled             = optional(bool, true)
    schedule = optional(object({
      frequency_interval       = number
      frequency_unit           = string
      keep_at_least_one_backup = optional(bool)
      retention_period_days    = optional(number)
      start_time               = optional(string)
    }))
  })
  default = null
}

variable "connection_strings" {
  description = "One or more connection_string blocks for the Function App"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = null
}

variable "identity" {
  description = "An identity block for the Function App"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "site_config" {
  description = "A site_config block for the Function App"
  type = object({
    always_on                                     = optional(bool)
    api_definition_url                            = optional(string)
    api_management_api_id                         = optional(string)
    app_command_line                              = optional(string)
    container_registry_managed_identity_client_id = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    default_documents                             = optional(list(string))
    elastic_instance_minimum                      = optional(number)
    ftps_state                                    = optional(string, "Disabled")
    health_check_path                             = optional(string)
    health_check_grace_period_seconds             = optional(number)
    http2_enabled                                 = optional(bool)
    load_balancing_mode                           = optional(string)
    managed_pipeline_mode                         = optional(string)
    minimum_tls_version                           = optional(string, "1.2")
    pre_warmed_instance_count                     = optional(number)
    remote_debugging_enabled                      = optional(bool)
    remote_debugging_version                      = optional(string)
    runtime_scale_monitoring_enabled              = optional(bool)
    scm_minimum_tls_version                       = optional(string, "1.2")
    scm_use_main_ip_restriction                   = optional(bool)
    use_32_bit_worker                             = optional(bool)
    vnet_route_all_enabled                        = optional(bool)
    websockets_enabled                            = optional(bool)
    worker_count                                  = optional(number)
    app_service_logs = optional(object({
      disk_quota_mb         = optional(number)
      retention_period_days = optional(number)
    }))
    application_stack = optional(object({
      dotnet_version              = optional(string)
      use_dotnet_isolated_runtime = optional(bool)
      java_version                = optional(string)
      node_version                = optional(string)
      python_version              = optional(string)
      powershell_core_version     = optional(string)
      use_custom_runtime          = optional(bool)
      docker = optional(object({
        registry_url      = string
        image_name        = string
        image_tag         = string
        registry_username = optional(string)
        registry_password = optional(string)
      }))
    }))
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    }))
    ip_restrictions = optional(list(object({
      action                    = optional(string, "Allow")
      headers                   = optional(map(list(string)))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number, 65000)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    scm_ip_restrictions = optional(list(object({
      action                    = optional(string, "Allow")
      headers                   = optional(map(list(string)))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number, 65000)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
  })
  default = {
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"
  }
}

variable "sticky_settings" {
  description = "A sticky_settings block for the Function App"
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

variable "storage_accounts" {
  description = "One or more storage_account blocks for the Function App"
  type = list(object({
    access_key   = string
    account_name = string
    name         = string
    share_name   = string
    type         = string
    mount_path   = optional(string)
  }))
  default = null
}
