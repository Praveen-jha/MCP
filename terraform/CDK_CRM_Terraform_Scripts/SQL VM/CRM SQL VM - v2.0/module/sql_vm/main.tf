resource "azurerm_mssql_virtual_machine" "main" {
  virtual_machine_id               = var.virtual_machine_id
  sql_connectivity_port            = var.sqlPortNumber
  sql_connectivity_type            = var.sqlConnectivityType
  sql_connectivity_update_username = var.sqlAuthenticationLogin
  sql_connectivity_update_password = var.sqlAuthenticationPassword
  sql_license_type                 = var.sql_license_type

  dynamic "storage_configuration" {
    for_each = var.storage_configuration == {} ? [] : ["storage_configuration"]
    content {
      disk_type                      = var.storage_configuration.disk_type
      storage_workload_type          = var.storage_configuration.storage_workload_type
      system_db_on_data_disk_enabled = var.storage_configuration.system_db_on_data_disk_enabled

      dynamic "data_settings" {
        for_each = var.storage_configuration.data_settings == {} ? [] : ["data_settings"]
        content {
          default_file_path = var.storage_configuration.data_settings.default_file_path
          luns              = var.storage_configuration.data_settings.luns
        }
      }

      dynamic "log_settings" {
        for_each = var.storage_configuration.log_settings == {} ? [] : ["log_settings"]
        content {
          default_file_path = var.storage_configuration.log_settings.default_file_path
          luns              = var.storage_configuration.log_settings.luns
        }
      }

      dynamic "temp_db_settings" {
        for_each = var.storage_configuration.temp_db_settings == {} ? [] : ["temp_db_settings"]
        content {
          default_file_path      = var.storage_configuration.temp_db_settings.default_file_path
          luns                   = var.storage_configuration.temp_db_settings.luns
          data_file_count        = var.storage_configuration.temp_db_settings.data_file_count
          data_file_growth_in_mb = var.storage_configuration.temp_db_settings.data_file_growth_in_mb
          data_file_size_mb      = var.storage_configuration.temp_db_settings.data_file_size_mb
          log_file_growth_mb     = var.storage_configuration.temp_db_settings.log_file_growth_mb
          log_file_size_mb       = var.storage_configuration.temp_db_settings.log_file_size_mb
        }
      }
    }
  }

  dynamic "sql_instance" {
    for_each = var.sql_instance == {} ? [] : ["sql_instance"]
    content {
      adhoc_workloads_optimization_enabled = var.sql_instance.adhoc_workloads_optimization_enabled
      collation                            = var.sql_instance.collation
      instant_file_initialization_enabled  = var.sql_instance.instant_file_initialization_enabled
      lock_pages_in_memory_enabled         = var.sql_instance.lock_pages_in_memory_enabled
      max_dop                              = var.sql_instance.max_dop
      max_server_memory_mb                 = var.sql_instance.max_server_memory_mb
      min_server_memory_mb                 = var.sql_instance.min_server_memory_mb
    }
  }

  dynamic "key_vault_credential" {
    for_each = var.key_vault_credential == {} ? [] : ["key_vault_credential"]
    content {
      key_vault_url            = var.key_vault_credential.key_vault_url
      name                     = var.key_vault_credential.key_vault_credential_name
      service_principal_name   = var.key_vault_credential.service_principal_name
      service_principal_secret = var.key_vault_credential.service_principal_secret
    }
  }

  dynamic "auto_patching" {
    for_each = var.auto_patching == {} ? [] : ["auto_patching"]
    content {
      day_of_week                            = var.auto_patching.day_of_week
      maintenance_window_duration_in_minutes = var.auto_patching.maintenance_window_duration_in_minutes
      maintenance_window_starting_hour       = var.auto_patching.maintenance_window_starting_hour
    }
  }

  dynamic "auto_backup" {
    for_each = var.auto_backup == {} ? [] : ["auto_backup"]
    content {
      encryption_password             = var.auto_backup.encryption_password
      retention_period_in_days        = var.auto_backup.retention_period_in_days
      storage_account_access_key      = var.auto_backup.storage_account_access_key
      storage_blob_endpoint           = var.auto_backup.storage_blob_endpoint
      system_databases_backup_enabled = var.auto_backup.system_databases_backup_enabled

      dynamic "manual_schedule" {
        for_each = var.auto_backup.manual_schedule == {} ? [] : ["manual_schedule"]
        content {
          days_of_week                    = var.auto_backup.manual_schedule.days_of_week
          full_backup_frequency           = var.auto_backup.manual_schedule.full_backup_frequency
          full_backup_start_hour          = var.auto_backup.manual_schedule.full_backup_start_hour
          full_backup_window_in_hours     = var.auto_backup.manual_schedule.full_backup_window_in_hours
          log_backup_frequency_in_minutes = var.auto_backup.manual_schedule.log_backup_frequency_in_minutes
        }
      }
    }
  }
}
