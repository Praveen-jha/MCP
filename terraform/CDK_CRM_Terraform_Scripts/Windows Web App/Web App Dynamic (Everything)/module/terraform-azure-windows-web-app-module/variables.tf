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

variable "client_affinity_enabled" {
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
  type        = bool
  default     = null
}

variable "client_certificate_enabled" {
  description = "Does the App Service require client certificates for incoming requests?"
  type        = bool
  default     = null
}

variable "enabled" {
  description = "Is the App Service Enabled?"
  type        = bool
  default     = null
}

variable "https_only" {
  description = "Can the App Service only be accessed via HTTPS?"
  type        = bool
  default     = null
}

variable "key_vault_reference_identity_id" {
  description = "The User Assigned Identity Id used for looking up KeyVault secrets. The identity must be assigned to the application."
  type        = string
  default     = null
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

variable "client_certificate_exclusion_paths" {
  type        = string
  description = "(Optional) Paths to exclude when using client certificates, separated by ;"
  default     = null
}

variable "client_certificate_mode" {
  type        = string
  description = "(Optional) The Client Certificate mode. Possible values are Required, Optional, and OptionalInteractiveUser. This property has no effect when client_cert_enabled is false"
  default     = null
}

variable "zip_deploy_file" {
  type        = string
  description = " (Optional) The local path and filename of the Zip packaged application to deploy to this Windows Web App."
  default     = null
}

variable "site_config" {
  description = "A site_config block as defined below."
  type = list(object({
    always_on                                     = optional(bool)
    api_command_line                              = optional(string)
    api_definition_url                            = optional(string) 
    api_management_api_id                         = optional(string) 
    app_command_line                              = optional(string)
    client_certificate_mode                       = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    container_registry_managed_identity_client_id = optional(string)
    default_documents                             = optional(list(string))
    ftps_state                                    = optional(string)
    health_check_path                             = optional(string) 
    health_check_eviction_time_in_min             = optional(number) 
    http2_enabled                                 = optional(bool)
    load_balancing_mode                           = optional(string)
    local_mysql_enabled                           = optional(bool)
    managed_pipeline_mode                         = optional(string)
    minimum_tls_version                           = optional(string) 
    remote_debugging_enabled                      = optional(bool)
    remote_debugging_version                      = optional(string)
    scm_minimum_tls_version                       = optional(string)
    scm_use_main_ip_restriction                   = optional(bool)
    use_32_bit_worker                             = optional(bool) 
    vnet_route_all_enabled                        = optional(bool)
    websockets_enabled                            = optional(bool)
    worker_count                                  = optional(number) 

    application_stack = optional(list(object({
      dotnet_version               = optional(string)
      current_stack                = optional(string)
      docker_registry_url          = optional(string)
      dotnet_core_version          = optional(string)
      java_embedded_server_enabled = optional(bool)
      tomcat_version               = optional(string)
      java_version                 = optional(string)
      node_version                 = optional(string)
      php_version                  = optional(string)
      python                       = optional(bool)
      docker_image_name            = optional(string)
      docker_registry_username     = optional(string)
      docker_registry_password     = optional(string)
    })))

    auto_heal_setting = optional(list(object({
      action = list(object({
        action_type = string
        custom_action = optional(list(object({
          executable = string
          parameters = optional(string)
        })))
      }))
      trigger = optional(list(object({
        private_memory_kb = optional(number)
        requests = optional(list(object({
          count    = number
          interval = string
        })))
        slow_request = optional(list(object({
          time_taken = string
          count      = number
          interval   = string
        })))
        status_code = optional(list(object({
          status_code_range = string
          count             = number
          interval          = string
        })))
      })))
    })))

    cors = optional(list(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    })))

    ip_restriction = optional(list(object({
      action                    = optional(string)
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(list(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      })))
    })))

    scm_ip_restriction = optional(list(object({
      action                    = optional(string)
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(list(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      })))
    })))
  }))
  default = []
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


variable "auth_settings" {
  description = "A auth_settings block as defined below. (Deprecated in favor of auth_settings_v2)"
  type = list(object({
    additional_login_params        = optional(map(string))
    allowed_external_redirect_urls = optional(list(string))
    default_provider               = optional(string)
    enabled                        = optional(bool)
    issuer                         = optional(string)
    runtime_version                = optional(string)
    token_refresh_extension_hours  = optional(number)
    token_store_enabled            = optional(bool)
    unauthenticated_client_action  = optional(string)

    active_directory = optional(list(object({
      client_id                  = string
      allowed_audiences          = optional(list(string))
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
    })))

    facebook = optional(list(object({
      app_id                  = string
      app_secret              = optional(string)
      app_secret_setting_name = optional(string)
      oauth_scopes            = optional(list(string))
    })))

    github = optional(list(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    })))

    google = optional(list(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    })))

    microsoft_account = optional(list(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    })))

    twitter = optional(list(object({
      consumer_key                 = string
      consumer_secret              = optional(string)
      consumer_secret_setting_name = optional(string)
    })))
  }))
  default = []
}

variable "auth_settings_v2" {
  description = "A auth_settings_v2 block as defined below."
  type = list(object({
    auth_enabled                            = optional(bool)
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

    active_directory_v2 = optional(list(object({
      client_id                            = string
      tenant_auth_endpoint                 = string 
      client_secret_certificate_thumbprint = optional(string)
      client_secret_setting_name           = optional(string)
      jwt_allowed_groups                   = optional(list(string))
      allowed_audiences                    = optional(list(string))
      jwt_allowed_client_applications      = optional(list(string))
      www_authentication_disabled          = optional(bool)
      allowed_groups                       = optional(list(string))
      allowed_identities                   = optional(list(string))
      allowed_applications                 = optional(list(string))
      login_parameters                     = optional(map(string))
    })))

    apple_v2 = optional(list(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    })))

    azure_static_web_app_v2 = optional(list(object({
      client_id = string
    })))

    custom_oidc_v2 = optional(list(object({
      name                          = string
      client_id                     = string
      openid_configuration_endpoint = string
      name_claim_type               = optional(string)
      scopes                        = optional(list(string))
      client_credential_method      = optional(string)
    })))

    facebook_v2 = optional(list(object({
      app_id                  = string
      app_secret_setting_name = string
      graph_api_version       = optional(string)
      login_scopes            = optional(list(string))
    })))

    github_v2 = optional(list(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    })))

    google_v2 = optional(list(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    })))

    microsoft_account_v2 = optional(list(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    })))

    twitter_v2 = optional(list(object({
      consumer_key                 = string
      consumer_secret_setting_name = string
    })))

    login = optional(list(object({
      allowed_external_redirect_urls    = optional(list(string))
      cookie_expiration_convention      = optional(string)
      cookie_expiration_time            = optional(string)
      logout_endpoint                   = optional(string)
      nonce_expiration_time             = optional(string)
      preserve_url_fragments_for_logins = optional(bool)
      token_refresh_extension_time      = optional(number)
      token_store_enabled               = optional(bool)
      token_store_path                  = optional(string)
      token_store_sas_setting_name      = optional(string)
      validate_nonce                    = optional(bool)
    })))
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

variable "sticky_settings" {
  description = "A sticky_settings block as defined below."
  type = list(object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  }))
  default = []
}
