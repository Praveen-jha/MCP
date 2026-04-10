#Terraform code defines an Azure Windows Web App resource using the azurerm_windows_web_app block. It provisions a Windows-based App Service that can host web applications, REST APIs, and mobile backends.
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/3.55.0/docs/resources/windows_web_app

resource "azurerm_windows_web_app" "this" {
  name                          = var.windows_web_app_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = var.service_plan_id
  https_only                    = var.https_only
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.virtual_network_subnet_id
  tags                          = var.tags

  app_settings = var.app_settings != null ? {
    for key, value in var.app_settings : key => value
  } : {}

  site_config {
    ftps_state             = try(var.site_config.ftps_state, null)
    minimum_tls_version    = try(var.site_config.minimum_tls_version, null)
    use_32_bit_worker      = try(var.site_config.use_32_bit_worker, null)
    vnet_route_all_enabled = try(var.site_config.vnet_route_all_enabled, null)
    worker_count           = try(var.site_config.worker_count, null)
    dynamic "application_stack" {
      for_each = try(var.site_config.application_stack, [])
      content {
        dotnet_version               = try(application_stack.value.dotnet_version, null)
        current_stack                = try(application_stack.value.current_stack, null)
        dotnet_core_version          = try(application_stack.value.dotnet_core_version, null)
        java_embedded_server_enabled = try(application_stack.value.java_embedded_server_enabled, null)
        python                       = try(application_stack.value.python, null)
        java_version                 = try(application_stack.value.java_version, null)
        node_version                 = try(application_stack.value.node_version, null)
        php_version                  = try(application_stack.value.php_version, null)
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
}
