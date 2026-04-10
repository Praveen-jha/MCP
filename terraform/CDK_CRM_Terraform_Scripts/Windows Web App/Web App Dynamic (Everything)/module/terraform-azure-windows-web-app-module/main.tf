#Terraform code defines an Azure Windows Web App resource using the azurerm_windows_web_app block. It provisions a Windows-based App Service that can host web applications, REST APIs, and mobile backends.
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/3.55.0/docs/resources/windows_web_app

resource "azurerm_windows_web_app" "this" {
  name                               = var.windows_web_app_name
  resource_group_name                = var.resource_group_name
  location                           = var.location
  service_plan_id                    = var.service_plan_id
  client_affinity_enabled            = var.client_affinity_enabled
  client_certificate_enabled         = var.client_certificate_enabled
  enabled                            = var.enabled
  https_only                         = var.https_only
  public_network_access_enabled      = var.public_network_access_enabled
  key_vault_reference_identity_id    = var.key_vault_reference_identity_id
  virtual_network_subnet_id          = var.virtual_network_subnet_id
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths
  client_certificate_mode            = var.client_certificate_mode
  zip_deploy_file                    = var.zip_deploy_file
  tags                               = var.tags

  app_settings = var.app_settings != null ? {
    for key, value in var.app_settings : key => value
  } : {}

  # dynamic "app_settings" {
  #   for_each = var.app_settings != null ? var.app_settings : {}
  #   content {
  #     key      = app_settings.key
  #     value    = app_settings.value
  #   }
  # }

  dynamic "site_config" {
    for_each = var.site_config
    content {
      always_on                                     = try(site_config.value.always_on, null)
      api_definition_url                            = try(site_config.value.api_definition_url, null)
      api_management_api_id                         = try(site_config.value.api_management_api_id, null)
      app_command_line                              = try(site_config.value.app_command_line, null)
      container_registry_use_managed_identity       = try(site_config.value.container_registry_use_managed_identity, null)
      container_registry_managed_identity_client_id = try(site_config.value.container_registry_managed_identity_client_id, null)
      default_documents                             = try(site_config.value.default_documents, null)
      ftps_state                                    = try(site_config.value.ftps_state, null)
      health_check_path                             = try(site_config.value.health_check_path, null)
      health_check_eviction_time_in_min             = try(site_config.value.health_check_eviction_time_in_min, null)
      http2_enabled                                 = try(site_config.value.http2_enabled, null)
      load_balancing_mode                           = try(site_config.value.load_balancing_mode, null)
      local_mysql_enabled                           = try(site_config.value.local_mysql_enabled, null)
      managed_pipeline_mode                         = try(site_config.value.managed_pipeline_mode, null)
      minimum_tls_version                           = try(site_config.value.minimum_tls_version, null)
      remote_debugging_enabled                      = try(site_config.value.remote_debugging_enabled, null)
      remote_debugging_version                      = try(site_config.value.remote_debugging_version, null)
      scm_minimum_tls_version                       = try(site_config.value.scm_minimum_tls_version, null)
      scm_use_main_ip_restriction                   = try(site_config.value.scm_use_main_ip_restriction, null)
      use_32_bit_worker                             = try(site_config.value.use_32_bit_worker, null)
      vnet_route_all_enabled                        = try(site_config.value.vnet_route_all_enabled, null)
      websockets_enabled                            = try(site_config.value.websockets_enabled, null)
      worker_count                                  = try(site_config.value.worker_count, null)

      dynamic "application_stack" {
        for_each = try(site_config.value.application_stack, [])
        content {
          dotnet_version               = try(application_stack.value.dotnet_version, null)
          current_stack                = try(application_stack.value.current_stack, null)
          docker_registry_url          = try(application_stack.value.docker_registry_url, null)
          dotnet_core_version          = try(application_stack.value.dotnet_core_version, null)
          java_embedded_server_enabled = try(application_stack.value.java_embedded_server_enabled, null)
          tomcat_version               = try(application_stack.value.tomcat_version, null)
          python                       = try(application_stack.value.python, null)
          java_version                 = try(application_stack.value.java_version, null)
          node_version                 = try(application_stack.value.node_version, null)
          php_version                  = try(application_stack.value.php_version, null)
          docker_image_name            = try(application_stack.value.docker_image_name, null)
          docker_registry_username     = try(application_stack.value.docker_registry_username, null)
          docker_registry_password     = try(application_stack.value.docker_registry_password, null)
        }
      }

      dynamic "auto_heal_setting" {
        for_each = try(site_config.value.auto_heal_setting, [])
        content {
          dynamic "action" {
            for_each = try(auto_heal_setting.value.action, [])
            content {
              action_type = action.value.action_type
              dynamic "custom_action" {
                for_each = try(action.value.custom_action, [])
                content {
                  executable = custom_action.value.executable
                  parameters = try(custom_action.value.parameters, null)
                }
              }
            }
          }

          dynamic "trigger" {
            for_each = try(auto_heal_setting.value.trigger, [])
            content {
              private_memory_kb = try(trigger.value.private_memory_kb, null)

              dynamic "requests" {
                for_each = try(trigger.value.requests, [])
                content {
                  count    = requests.value.count
                  interval = requests.value.interval
                }
              }

              dynamic "slow_request" {
                for_each = try(trigger.value.slow_request, [])
                content {
                  time_taken = slow_request.value.time_taken
                  count      = slow_request.value.count
                  interval   = slow_request.value.interval
                }
              }

              dynamic "status_code" {
                for_each = try(trigger.value.status_code, [])
                content {
                  status_code_range = status_code.value.status_code_range
                  count             = status_code.value.count
                  interval          = status_code.value.interval
                }
              }
            }
          }
        }
      }

      dynamic "cors" {
        for_each = try(site_config.value.cors, [])
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = try(cors.value.support_credentials, null)
        }
      }

      dynamic "ip_restriction" {
        for_each = try(site_config.value.ip_restriction, [])
        content {
          action                    = try(ip_restriction.value.action, null)
          ip_address                = try(ip_restriction.value.ip_address, null)
          name                      = try(ip_restriction.value.name, null)
          priority                  = try(ip_restriction.value.priority, null)
          service_tag               = try(ip_restriction.value.service_tag, null)
          virtual_network_subnet_id = try(ip_restriction.value.virtual_network_subnet_id, null)

          dynamic "headers" {
            for_each = try(ip_restriction.value.headers, [])
            content {
              x_azure_fdid      = try(headers.value.x_azure_fdid, null)
              x_fd_health_probe = try(headers.value.x_fd_health_probe, null)
              x_forwarded_for   = try(headers.value.x_forwarded_for, null)
              x_forwarded_host  = try(headers.value.x_forwarded_host, null)
            }
          }
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = try(site_config.value.scm_ip_restriction, [])
        content {
          action                    = try(scm_ip_restriction.value.action, null)
          ip_address                = try(scm_ip_restriction.value.ip_address, null)
          name                      = try(scm_ip_restriction.value.name, null)
          priority                  = try(scm_ip_restriction.value.priority, null)
          service_tag               = try(scm_ip_restriction.value.service_tag, null)
          virtual_network_subnet_id = try(scm_ip_restriction.value.virtual_network_subnet_id, null)

          dynamic "headers" {
            for_each = try(scm_ip_restriction.value.headers, [])
            content {
              x_azure_fdid      = try(headers.value.x_azure_fdid, null)
              x_fd_health_probe = try(headers.value.x_fd_health_probe, null)
              x_forwarded_for   = try(headers.value.x_forwarded_for, null)
              x_forwarded_host  = try(headers.value.x_forwarded_host, null)
            }
          }
        }
      }

      dynamic "virtual_application" {
        for_each = try(site_config.value.virtual_applications, [])
        content {
          physical_path = virtual_application.value.physical_path
          preload       = virtual_application.value.preload
          virtual_path  = virtual_application.value.virtual_path

          dynamic "virtual_directory" {
            for_each = try(virtual_application.value.virtual_directories, [])
            content {
              physical_path = try(virtual_directory.value.physical_path, null)
              virtual_path  = try(virtual_directory.value.virtual_path, null)
            }
          }
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_string != null ? var.connection_string : []
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "auth_settings" {
    for_each = var.auth_settings != null ? var.auth_settings : []
    content {
      allowed_external_redirect_urls = try(auth_settings.value.allowed_external_redirect_urls, null)
      additional_login_parameters    = try(auth_settings.value.additional_login_params, null)
      default_provider               = try(auth_settings.value.default_provider, null)
      enabled                        = try(auth_settings.value.enabled, null)
      issuer                         = try(auth_settings.value.issuer, null)
      runtime_version                = try(auth_settings.value.runtime_version, null)
      unauthenticated_client_action  = try(auth_settings.value.unauthenticated_client_action, null)
      token_refresh_extension_hours  = try(auth_settings.value.token_refresh_extension_hours, null)
      token_store_enabled            = try(auth_settings.value.token_store_enabled, null)

      dynamic "active_directory" {
        for_each = try(auth_settings.value.active_directory, [])
        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = try(active_directory.value.allowed_audiences, null)
          client_secret              = try(active_directory.value.client_secret, null)
          client_secret_setting_name = try(active_directory.value.client_secret_setting_name, null)
        }
      }

      dynamic "facebook" {
        for_each = try(auth_settings.value.facebook, [])
        content {
          app_id                  = facebook.value.app_id
          app_secret              = try(facebook.value.app_secret, null)
          app_secret_setting_name = try(facebook.value.app_secret_setting_name, null)
          oauth_scopes            = try(facebook.value.oauth_scopes, null)
        }
      }

      dynamic "github" {
        for_each = try(auth_settings.value.github, [])
        content {
          client_id                  = github.value.client_id
          client_secret              = try(github.value.client_secret, null)
          client_secret_setting_name = try(github.value.client_secret_setting_name, null)
          oauth_scopes               = try(github.value.oauth_scopes, null)
        }
      }

      dynamic "google" {
        for_each = try(auth_settings.value.google, [])
        content {
          client_id                  = google.value.client_id
          client_secret              = try(google.value.client_secret, null)
          client_secret_setting_name = try(google.value.client_secret_setting_name, null)
          oauth_scopes               = try(google.value.oauth_scopes, null)
        }
      }

      dynamic "microsoft" {
        for_each = try(auth_settings.value.microsoft_account, [])
        content {
          client_id                  = microsoft_account.value.client_id
          client_secret              = try(microsoft_account.value.client_secret, null)
          client_secret_setting_name = try(microsoft_account.value.client_secret_setting_name, null)
          oauth_scopes               = try(microsoft_account.value.oauth_scopes, null)
        }
      }

      dynamic "twitter" {
        for_each = try(auth_settings.value.twitter, [])
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = try(twitter.value.consumer_secret, null)
          consumer_secret_setting_name = try(twitter.value.consumer_secret_setting_name, null)
        }
      }
    }
  }

  dynamic "auth_settings_v2" {
    for_each = var.auth_settings_v2 != null ? var.auth_settings_v2 : []
    content {
      auth_enabled                            = try(auth_settings_v2.value.auth_enabled, null)
      runtime_version                         = try(auth_settings_v2.value.runtime_version, null)
      config_file_path                        = try(auth_settings_v2.value.config_file_path, null)
      require_authentication                  = try(auth_settings_v2.value.require_authentication, null)
      unauthenticated_action                  = try(auth_settings_v2.value.unauthenticated_action, null)
      default_provider                        = try(auth_settings_v2.value.default_provider, null)
      excluded_paths                          = try(auth_settings_v2.value.excluded_paths, null)
      require_https                           = try(auth_settings_v2.value.require_https, null)
      http_route_api_prefix                   = try(auth_settings_v2.value.http_route_api_prefix, null)
      forward_proxy_convention                = try(auth_settings_v2.value.forward_proxy_convention, null)
      forward_proxy_custom_host_header_name   = try(auth_settings_v2.value.forward_proxy_custom_host_header_name, null)
      forward_proxy_custom_scheme_header_name = try(auth_settings_v2.value.forward_proxy_custom_scheme_header_name, null)

      dynamic "active_directory_v2" {
        for_each = try(auth_settings_v2.value.active_directory_v2, [])
        content {
          client_id                            = active_directory_v2.value.client_id
          tenant_auth_endpoint                 = active_directory_v2.value.tenant_auth_endpoint
          client_secret_certificate_thumbprint = try(active_directory_v2.value.client_secret_certificate_thumbprint, null)
          client_secret_setting_name           = try(active_directory_v2.value.client_secret_setting_name, null)
          allowed_audiences                    = try(active_directory_v2.value.allowed_audiences, null)
          jwt_allowed_groups                   = try(active_directory_v2.value.jwt_allowed_groups, null)
          jwt_allowed_client_applications      = try(active_directory_v2.value.jwt_allowed_client_applications, null)
          www_authentication_disabled          = try(active_directory_v2.value.www_authentication_disabled, null)
          allowed_groups                       = try(active_directory_v2.value.allowed_groups, null)
          allowed_identities                   = try(active_directory_v2.value.allowed_identities, null)
          allowed_applications                 = try(active_directory_v2.value.allowed_applications, null)
          login_parameters                     = try(active_directory_v2.value.login_parameters, null)
        }
      }



      dynamic "apple_v2" {
        for_each = try(auth_settings_v2.value.apple_v2, [])
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = apple_v2.value.client_secret_setting_name
          login_scopes               = try(apple_v2.value.login_scopes, null)
        }
      }

      dynamic "azure_static_web_app_v2" {
        for_each = try(auth_settings_v2.value.azure_static_web_app_v2, [])
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = try(auth_settings_v2.value.custom_oidc_v2, [])
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = try(custom_oidc_v2.value.name_claim_type, null)
          scopes                        = try(custom_oidc_v2.value.scopes, null)
        }
      }

      dynamic "facebook_v2" {
        for_each = try(auth_settings_v2.value.facebook_v2, [])
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = try(facebook_v2.value.graph_api_version, null)
          login_scopes            = try(facebook_v2.value.login_scopes, null)
        }
      }

      dynamic "github_v2" {
        for_each = try(auth_settings_v2.value.github_v2, [])
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = try(github_v2.value.login_scopes, null)
        }
      }

      dynamic "google_v2" {
        for_each = try(auth_settings_v2.value.google_v2, [])
        content {
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          allowed_audiences          = try(google_v2.value.allowed_audiences, null)
          login_scopes               = try(google_v2.value.login_scopes, null)
        }
      }

      dynamic "microsoft_v2" {
        for_each = try(auth_settings_v2.value.microsoft_account_v2, [])
        content {
          client_id                  = microsoft_account_v2.value.client_id
          client_secret_setting_name = microsoft_account_v2.value.client_secret_setting_name
          allowed_audiences          = try(microsoft_account_v2.value.allowed_audiences, null)
          login_scopes               = try(microsoft_account_v2.value.login_scopes, null)
        }
      }

      dynamic "twitter_v2" {
        for_each = try(auth_settings_v2.value.twitter_v2, [])
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }

      dynamic "login" {
        for_each = try(auth_settings_v2.value.login, [])
        content {
          allowed_external_redirect_urls    = try(login.value.allowed_external_redirect_urls, null)
          cookie_expiration_convention      = try(login.value.cookie_expiration_convention, null)
          cookie_expiration_time            = try(login.value.cookie_expiration_time, null)
          logout_endpoint                   = try(login.value.logout_endpoint, null)
          nonce_expiration_time             = try(login.value.nonce_expiration_time, null)
          preserve_url_fragments_for_logins = try(login.value.preserve_url_fragments_for_logins, null)
          token_refresh_extension_time      = try(login.value.token_refresh_extension_time, null)
          token_store_enabled               = try(login.value.token_store_enabled, null)
          token_store_path                  = try(login.value.token_store_path, null)
          token_store_sas_setting_name      = try(login.value.token_store_sas_setting_name, null)
          validate_nonce                    = try(login.value.validate_nonce, null)
        }
      }
    }
  }

  dynamic "backup" {
    for_each = var.backup != null ? var.backup : []
    content {
      enabled             = try(backup.value.enabled, null)
      name                = backup.value.name
      storage_account_url = backup.value.storage_account_url

      dynamic "schedule" {
        for_each = try(backup.value.schedule, [])
        content {
          frequency_interval       = schedule.value.frequency_interval
          frequency_unit           = schedule.value.frequency_unit
          retention_period_days    = schedule.value.retention_period_days
          keep_at_least_one_backup = try(schedule.value.keep_at_least_one_backup, null)
          start_time               = try(schedule.value.start_time, null)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? var.identity : []
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "logs" {
    for_each = var.logs != null ? var.logs : []
    content {
      detailed_error_messages = try(logs.value.detailed_error_messages_enabled, null)
      failed_request_tracing  = try(logs.value.failed_request_tracing_enabled, null)
      dynamic "application_logs" {
        for_each = try(logs.value.application_logs, [])
        content {
          file_system_level = application_logs.value.file_system_level

          dynamic "azure_blob_storage" {
            for_each = try(application_logs.value.azure_blob_storage, [])
            content {
              level             = azure_blob_storage.value.level
              retention_in_days = azure_blob_storage.value.retention_in_days
              sas_url           = azure_blob_storage.value.sas_url
            }
          }
        }
      }

      dynamic "http_logs" {
        for_each = try(logs.value.http_logs, [])
        content {
          dynamic "file_system" {
            for_each = try(http_logs.value.file_system, [])
            content {
              retention_in_days = file_system.value.retention_in_days
              retention_in_mb   = file_system.value.retention_in_mb
            }
          }

          dynamic "azure_blob_storage" {
            for_each = try(http_logs.value.azure_blob_storage, [])
            content {
              retention_in_days = try(azure_blob_storage.value.retention_in_days, null)
              sas_url           = azure_blob_storage.value.sas_url
            }
          }
        }
      }
    }
  }

  dynamic "storage_account" {
    for_each = var.storage_accounts != null ? var.storage_accounts : []
    content {
      name         = storage_accounts.value.name
      access_key   = storage_accounts.value.access_key
      account_name = storage_accounts.value.account_name
      mount_path   = try(storage_accounts.value.mount_path, null)
      share_name   = storage_accounts.value.share_name
      type         = storage_accounts.value.type
    }
  }

  dynamic "sticky_settings" {
    for_each = var.sticky_settings != null ? var.sticky_settings : []
    content {
      app_setting_names       = try(sticky_settings.value.app_setting_names, null)
      connection_string_names = try(sticky_settings.value.connection_string_names, null)
    }
  }
}
