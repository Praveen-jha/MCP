# The terraform resource block attaches a mssql virtual machine to an existing Azure Virtual Machine.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine


resource "azurerm_mssql_virtual_machine" "this" {
  virtual_machine_id               = var.mssql_vm_virtual_machine_id
  sql_connectivity_port            = var.mssql_vm_sqlPortNumber
  sql_connectivity_type            = var.mssql_vm_sqlConnectivityType
  sql_connectivity_update_username = var.mssql_vm_sqlAuthenticationLogin
  sql_connectivity_update_password = var.mssql_vm_sqlAuthenticationPassword
  r_services_enabled               = try(var.mssql_vm_r_services_enabled, null)
  sql_license_type                 = try(var.mssql_vm_sql_license_type, null)
  sql_virtual_machine_group_id     = try(var.mssql_vm_sql_virtual_machine_group_id, null)
  tags                             = var.mssql_vm_tags

  dynamic "storage_configuration" {
    for_each = var.mssql_vm_storage_configuration == null ? [] : ["storage_configuration"]
    content {
      disk_type                      = var.mssql_vm_storage_configuration.disk_type
      storage_workload_type          = var.mssql_vm_storage_configuration.storage_workload_type
      system_db_on_data_disk_enabled = var.mssql_vm_storage_configuration.system_db_on_data_disk_enabled

      dynamic "data_settings" {
        for_each = var.mssql_vm_storage_configuration.data_settings == null ? [] : ["data_settings"]
        content {
          default_file_path = var.mssql_vm_storage_configuration.data_settings.default_file_path
          luns              = var.mssql_vm_storage_configuration.data_settings.luns
        }
      }

      dynamic "log_settings" {
        for_each = var.mssql_vm_storage_configuration.log_settings == null ? [] : ["log_settings"]
        content {
          default_file_path = var.mssql_vm_storage_configuration.log_settings.default_file_path
          luns              = var.mssql_vm_storage_configuration.log_settings.luns
        }
      }

      dynamic "temp_db_settings" {
        for_each = var.mssql_vm_storage_configuration.temp_db_settings == null ? [] : ["temp_db_settings"]
        content {
          default_file_path      = var.mssql_vm_storage_configuration.temp_db_settings.default_file_path
          luns                   = var.mssql_vm_storage_configuration.temp_db_settings.luns
          data_file_count        = var.mssql_vm_storage_configuration.temp_db_settings.data_file_count
          data_file_growth_in_mb = var.mssql_vm_storage_configuration.temp_db_settings.data_file_growth_in_mb
          data_file_size_mb      = var.mssql_vm_storage_configuration.temp_db_settings.data_file_size_mb
          log_file_growth_mb     = var.mssql_vm_storage_configuration.temp_db_settings.log_file_growth_mb
          log_file_size_mb       = var.mssql_vm_storage_configuration.temp_db_settings.log_file_size_mb
        }
      }
    }
  }

  dynamic "sql_instance" {
    for_each = var.mssql_vm_sql_instance == null ? [] : ["sql_instance"]
    content {
      adhoc_workloads_optimization_enabled = var.mssql_vm_sql_instance.adhoc_workloads_optimization_enabled
      collation                            = var.mssql_vm_sql_instance.collation
      instant_file_initialization_enabled  = var.mssql_vm_sql_instance.instant_file_initialization_enabled
      lock_pages_in_memory_enabled         = var.mssql_vm_sql_instance.lock_pages_in_memory_enabled
      max_dop                              = var.mssql_vm_sql_instance.max_dop
      max_server_memory_mb                 = var.mssql_vm_sql_instance.max_server_memory_mb
      min_server_memory_mb                 = var.mssql_vm_sql_instance.min_server_memory_mb
    }
  }

  dynamic "key_vault_credential" {
    for_each = var.mssql_vm_key_vault_credential == [] ? [] : var.mssql_vm_key_vault_credential
    content {
      key_vault_url            = mssql_vm_key_vault_credential.value.key_vault_url
      name                     = mssql_vm_key_vault_credential.value.key_vault_credential_name
      service_principal_name   = mssql_vm_key_vault_credential.value.service_principal_name
      service_principal_secret = mssql_vm_key_vault_credential.value.service_principal_secret
    }
  }

  dynamic "auto_patching" {
    for_each = var.mssql_vm_auto_patching == [] ? [] : var.mssql_vm_auto_patching
    content {
      day_of_week                            = var.mssql_vm_auto_patching[0].day_of_week
      maintenance_window_starting_hour       = var.mssql_vm_auto_patching[0].maintenance_window_starting_hour
      maintenance_window_duration_in_minutes = var.mssql_vm_auto_patching[0].maintenance_window_duration_in_minutes
    }
  }

  dynamic "auto_backup" {
    for_each = var.mssql_vm_auto_backup == [] ? [] : var.mssql_vm_auto_backup
    content {
      encryption_password             = var.mssql_vm_auto_backup[0].encryption_password
      retention_period_in_days        = var.mssql_vm_auto_backup[0].retention_period_in_days
      storage_blob_endpoint           = var.mssql_vm_auto_backup[0].storage_blob_endpoint
      storage_account_access_key      = var.mssql_vm_auto_backup[0].storage_account_access_key
      system_databases_backup_enabled = var.mssql_vm_auto_backup[0].system_databases_backup_enabled

      dynamic "manual_schedule" {
        for_each = var.mssql_vm_auto_backup[0].manual_schedule == [] ? [] : var.mssql_vm_auto_backup[0].manual_schedule
        content {
          full_backup_frequency           = var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_frequency
          full_backup_start_hour          = var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_start_hour
          full_backup_window_in_hours     = var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_window_in_hours
          log_backup_frequency_in_minutes = var.mssql_vm_auto_backup[0].manual_schedule[0].log_backup_frequency_in_minutes
          days_of_week                    = var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_frequency == "Weekly" ? var.mssql_vm_auto_backup[0].manual_schedule[0].days_of_week : null
        }
      }
    }
  }

  dynamic "assessment" {
    for_each = var.mssql_vm_assessment == [] ? [] : var.mssql_vm_assessment
    content {
      enabled         = var.mssql_vm_assessment[0].enabled
      run_immediately = var.mssql_vm_assessment[0].run_immediately
      dynamic "schedule" {
        for_each = var.mssql_vm_assessment[0].schedule == null ? [] : var.mssql_vm_assessment[0].schedule
        content {
          weekly_interval    = try(var.mssql_vm_assessment[0].schedule.weekly_interval, null)
          monthly_occurrence = try(var.mssql_vm_assessment[0].schedule.monthly_occurrence, null)
          day_of_week        = var.mssql_vm_assessment[0].schedule.day_of_week
          start_time         = var.mssql_vm_assessment[0].schedule.start_time
        }
      }
    }
  }
  
  dynamic "wsfc_domain_credential" {
    for_each = var.mssql_vm_wsfc_domain_credential == [] ? [] : var.mssql_vm_wsfc_domain_credential
    content {
      cluster_bootstrap_account_password = wsfc_domain_credential.value.cluster_bootstrap_account_password
      cluster_operator_account_password  = wsfc_domain_credential.value.cluster_operator_account_password
      sql_service_account_password       = wsfc_domain_credential.value.sql_service_account_password
    }
  }

}
