resource "azurerm_windows_function_app" "this" {
  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  # Storage Account Configuration
  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_account_access_key
  # storage_key_vault_secret_id   = var.storage_key_vault_secret_id
  # storage_uses_managed_identity = var.storage_uses_managed_identity

  # Optional Basic Configuration
  app_settings                                   = var.app_settings
  builtin_logging_enabled                        = var.builtin_logging_enabled
  client_certificate_enabled                     = var.client_certificate_enabled
  client_certificate_mode                        = var.client_certificate_mode
  client_certificate_exclusion_paths             = var.client_certificate_exclusion_paths
  daily_memory_time_quota                        = var.daily_memory_time_quota
  enabled                                        = var.enabled
  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled
  functions_extension_version                    = var.functions_extension_version
  https_only                                     = var.https_only
  public_network_access_enabled                  = var.public_network_access_enabled
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  zip_deploy_file                                = var.zip_deploy_file

  # Site Config
  site_config {
    always_on                              = var.site_config.always_on
    api_definition_url                     = var.site_config.api_definition_url
    api_management_api_id                  = var.site_config.api_management_api_id
    app_command_line                       = var.site_config.app_command_line
    app_scale_limit                        = var.site_config.app_scale_limit
    application_insights_connection_string = var.site_config.application_insights_connection_string
    application_insights_key               = var.site_config.application_insights_key
    default_documents                      = var.site_config.default_documents
    elastic_instance_minimum               = var.site_config.elastic_instance_minimum
    ftps_state                             = var.site_config.ftps_state
    health_check_path                      = var.site_config.health_check_path
    # health_check_grace_period              = var.site_config.health_check_grace_period
    http2_enabled                          = var.site_config.http2_enabled
    load_balancing_mode                    = var.site_config.load_balancing_mode
    managed_pipeline_mode                  = var.site_config.managed_pipeline_mode
    minimum_tls_version                    = var.site_config.minimum_tls_version
    pre_warmed_instance_count              = var.site_config.pre_warmed_instance_count
    remote_debugging_enabled               = var.site_config.remote_debugging_enabled
    remote_debugging_version               = var.site_config.remote_debugging_version
    runtime_scale_monitoring_enabled       = var.site_config.runtime_scale_monitoring_enabled
    scm_minimum_tls_version                = var.site_config.scm_minimum_tls_version
    scm_use_main_ip_restriction            = var.site_config.scm_use_main_ip_restriction
    use_32_bit_worker                      = var.site_config.use_32_bit_worker
    vnet_route_all_enabled                 = var.site_config.vnet_route_all_enabled
    websockets_enabled                     = var.site_config.websockets_enabled
    worker_count                           = var.site_config.worker_count

    # Application Stack - Only one should be specified
    dynamic "application_stack" {
      for_each = var.site_config.application_stack != null ? [var.site_config.application_stack] : []
      content {
        dotnet_version              = application_stack.value.dotnet_version
        java_version                = application_stack.value.java_version
        node_version                = application_stack.value.node_version
        powershell_core_version     = application_stack.value.powershell_core_version
        # python_version              = application_stack.value.python_version
        use_custom_runtime          = application_stack.value.use_custom_runtime
        use_dotnet_isolated_runtime = application_stack.value.use_dotnet_isolated_runtime
      }
    }

    # CORS Configuration
    dynamic "cors" {
      for_each = var.site_config.cors != null ? [var.site_config.cors] : []
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }

    # IP Restrictions
    dynamic "ip_restriction" {
      for_each = var.site_config.ip_restrictions
      content {
        action                    = ip_restriction.value.action
        ip_address                = ip_restriction.value.ip_address
        name                      = ip_restriction.value.name
        priority                  = ip_restriction.value.priority
        service_tag               = ip_restriction.value.service_tag
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id

        dynamic "headers" {
          for_each = ip_restriction.value.headers != null ? [ip_restriction.value.headers] : []
          content {
            x_azure_fdid      = headers.value.x_azure_fdid
            x_fd_health_probe = headers.value.x_fd_health_probe
            x_forwarded_for   = headers.value.x_forwarded_for
            x_forwarded_host  = headers.value.x_forwarded_host
          }
        }
      }
    }

    # SCM IP Restrictions
    dynamic "scm_ip_restriction" {
      for_each = var.site_config.scm_ip_restrictions
      content {
        action                    = scm_ip_restriction.value.action
        ip_address                = scm_ip_restriction.value.ip_address
        name                      = scm_ip_restriction.value.name
        priority                  = scm_ip_restriction.value.priority
        service_tag               = scm_ip_restriction.value.service_tag
        virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id

        dynamic "headers" {
          for_each = scm_ip_restriction.value.headers != null ? [scm_ip_restriction.value.headers] : []
          content {
            x_azure_fdid      = headers.value.x_azure_fdid
            x_fd_health_probe = headers.value.x_fd_health_probe
            x_forwarded_for   = headers.value.x_forwarded_for
            x_forwarded_host  = headers.value.x_forwarded_host
          }
        }
      }
    }
  }

  # Authentication Settings
  dynamic "auth_settings" {
    for_each = var.auth_settings != null ? [var.auth_settings] : []
    content {
      enabled                        = auth_settings.value.enabled
      additional_login_parameters    = auth_settings.value.additional_login_parameters
      allowed_external_redirect_urls = auth_settings.value.allowed_external_redirect_urls
      default_provider               = auth_settings.value.default_provider
      issuer                         = auth_settings.value.issuer
      runtime_version                = auth_settings.value.runtime_version
      token_refresh_extension_hours  = auth_settings.value.token_refresh_extension_hours
      token_store_enabled            = auth_settings.value.token_store_enabled
      unauthenticated_client_action  = auth_settings.value.unauthenticated_client_action

      dynamic "active_directory" {
        for_each = auth_settings.value.active_directory != null ? [auth_settings.value.active_directory] : []
        content {
          client_id                  = active_directory.value.client_id
          client_secret              = active_directory.value.client_secret
          client_secret_setting_name = active_directory.value.client_secret_setting_name
          allowed_audiences          = active_directory.value.allowed_audiences
        }
      }

      dynamic "facebook" {
        for_each = auth_settings.value.facebook != null ? [auth_settings.value.facebook] : []
        content {
          app_id                  = facebook.value.app_id
          app_secret              = facebook.value.app_secret
          app_secret_setting_name = facebook.value.app_secret_setting_name
          oauth_scopes            = facebook.value.oauth_scopes
        }
      }

      dynamic "github" {
        for_each = auth_settings.value.github != null ? [auth_settings.value.github] : []
        content {
          client_id                  = github.value.client_id
          client_secret              = github.value.client_secret
          client_secret_setting_name = github.value.client_secret_setting_name
          oauth_scopes               = github.value.oauth_scopes
        }
      }

      dynamic "google" {
        for_each = auth_settings.value.google != null ? [auth_settings.value.google] : []
        content {
          client_id                  = google.value.client_id
          client_secret              = google.value.client_secret
          client_secret_setting_name = google.value.client_secret_setting_name
          oauth_scopes               = google.value.oauth_scopes
        }
      }

      dynamic "microsoft" {
        for_each = auth_settings.value.microsoft != null ? [auth_settings.value.microsoft] : []
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = microsoft.value.client_secret
          client_secret_setting_name = microsoft.value.client_secret_setting_name
          oauth_scopes               = microsoft.value.oauth_scopes
        }
      }

      dynamic "twitter" {
        for_each = auth_settings.value.twitter != null ? [auth_settings.value.twitter] : []
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = twitter.value.consumer_secret
          consumer_secret_setting_name = twitter.value.consumer_secret_setting_name
        }
      }
    }
  }

  # Backup Configuration
  dynamic "backup" {
    for_each = var.backup != null ? [var.backup] : []
    content {
      name                = backup.value.name
      storage_account_url = backup.value.storage_account_url
      enabled             = backup.value.enabled

      schedule {
        frequency_interval       = backup.value.schedule.frequency_interval
        frequency_unit           = backup.value.schedule.frequency_unit
        keep_at_least_one_backup = backup.value.schedule.keep_at_least_one_backup
        retention_period_days    = backup.value.schedule.retention_period_days
        start_time               = backup.value.schedule.start_time
      }
    }
  }

  # Connection Strings
  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  # Managed Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Sticky Settings
  dynamic "sticky_settings" {
    for_each = var.sticky_settings != null ? [var.sticky_settings] : []
    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
