// variables.tf
// This file defines the input variables for the azurerm_mssql_virtual_machine module.

variable "mssql_vm_virtual_machine_id" {
  description = "(Required) Virtual Machine Resource ID."
  type        = string
}

# Optional Variables
variable "mssql_vm_sqlPortNumber" {
  description = "The port number for SQL connectivity."
  type        = number
  default     = 1433
}

variable "mssql_vm_sqlConnectivityType" {
  description = "The SQL connectivity type (e.g., 'Private', 'Public')."
  type        = string
  default     = "PRIVATE"

  validation {
    condition     = contains(["LOCAL", "PRIVATE", "PUBLIC"], var.mssql_vm_sqlConnectivityType)
    error_message = "SQL Server Connectivity Type can be either 'LOCAL', 'PRIVATE', or 'PUBLIC'."
  }
}

variable "mssql_vm_sqlAuthenticationLogin" {
  description = "The SQL Authentication login username."
  type        = string
}

variable "mssql_vm_sqlAuthenticationPassword" {
  description = "The SQL Authentication login password."
  type        = string
  sensitive   = true
}

variable "mssql_vm_r_services_enabled" {
  description = "Defines whether to enable R Services or not"
  type        = bool
  default     = null
  nullable    = true
}

variable "mssql_vm_sql_license_type" {
  description = "(Optional) The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go)"
  type        = string
  default     = null

  validation {
    condition     = var.mssql_vm_sql_license_type != null ? contains(["AHUB", "DR", "PAYG"], var.mssql_vm_sql_license_type) : true
    error_message = "SQL Server License can be either 'AHUB', 'DR', 'PAYG', or 'null'."
  }
}

variable "mssql_vm_sql_virtual_machine_group_id" {
  description = "Defines the ID of the SQL Virtual Machine Group that the SQL Virtual Machine belongs to"
  type        = string
  default     = null
}

variable "mssql_vm_tags" {
  description = "(Optional) Tags to apply to the mssql virtual machine."
  type        = map(string)
}

variable "mssql_vm_storage_configuration" {
  description = "Variable for Storage Configuration Values,The type of disk configuration to apply to the SQL Server, The type of storage workload, Specifies whether to set system databases (except tempDb) location to newly created data storage, The SQL Server default path, A list of Logical Unit Numbers for the disks, The SQL Server default file count, The SQL Server default file size, etc."
  type = object({
    disk_type                      = string                //(Required) The type of disk configuration to apply to the SQL Server. Valid values include NEW, EXTEND, or ADD.
    storage_workload_type          = string                //(Required) The type of storage workload. Valid values include GENERAL, OLTP, or DW.
    system_db_on_data_disk_enabled = optional(bool, false) //(Optional) Specifies whether to set system databases (except tempDb) location to newly created data storage. Possible values are true and false. Defaults to false.
    data_settings = optional(object({
      default_file_path = string       //(Required) The SQL Server default path
      luns              = list(number) //(Required) A list of Logical Unit Numbers for the disks.
    }), null)
    log_settings = optional(object({
      default_file_path = string       //(Required) The SQL Server default path
      luns              = list(number) //(Required) A list of Logical Unit Numbers for the disks.
    }), null)
    temp_db_settings = optional(object({
      default_file_path      = string                //(Required) The SQL Server default path
      luns                   = list(number)          //(Required) A list of Logical Unit Numbers for the disks.
      data_file_count        = optional(number, 8)   //(Optional) The SQL Server default file count. This value defaults to 8
      data_file_size_mb      = optional(number, 256) //(Optional) The SQL Server default file size - This value defaults to 256
      data_file_growth_in_mb = optional(number, 512) // (Optional) The SQL Server default file size - This value defaults to 512
      log_file_size_mb       = optional(number, 256) //(Optional) The SQL Server default file size - This value defaults to 256
      log_file_growth_mb     = optional(number, 512) //(Optional) The SQL Server default file size - This value defaults to 512
    }), null)
  })
  nullable = true
  default  = null

  validation {
    condition     = var.mssql_vm_storage_configuration != null ? contains(["NEW", "EXTEND", "ADD"], var.mssql_vm_storage_configuration.disk_type) : true
    error_message = "disk_type must be either NEW, EXTEND, or ADD."
  }

  validation {
    condition     = var.mssql_vm_storage_configuration != null ? contains(["GENERAL", "OLTP", "DW"], var.mssql_vm_storage_configuration.storage_workload_type) : true
    error_message = "storage_workload_type must be either GENERAL, OLTP, or DW."
  }
}

variable "mssql_vm_sql_instance" {
  description = "Variable for SQL Instance Values, Colation, max dop, minimum server memory, maximum server memory, lock pages in memory enable, indstant file initializatin enabled and adhoc workload optimization enabled."
  type = object({
    adhoc_workloads_optimization_enabled = optional(bool, false)                            //(Optional) Specifies if the SQL Server is optimized for adhoc workloads. Possible values are true and false. Defaults to false.
    collation                            = optional(string, "SQL_Latin1_General_CP1_CI_AS") //(Optional) Collation of the SQL Server. Defaults to SQL_Latin1_General_CP1_CI_AS. 
    instant_file_initialization_enabled  = optional(bool, false)                            //(Optional) Specifies if Instant File Initialization is enabled for the SQL Server. Possible values are true and false. Defaults to false.
    lock_pages_in_memory_enabled         = optional(bool, false)                            //(Optional) Specifies if Lock Pages in Memory is enabled for the SQL Server. Possible values are true and false. Defaults to false. 
    max_dop                              = optional(number, 0)                              //(Optional) Maximum Degree of Parallelism of the SQL Server. Possible values are between 0 and 32767. Defaults to 0.
    max_server_memory_mb                 = optional(number, 2147483647)                     //(Optional) Maximum amount memory that SQL Server Memory Manager can allocate to the SQL Server process. Possible values are between 128 and 2147483647 Defaults to 2147483647.
    min_server_memory_mb                 = optional(number, 0)                              //(Optional) Minimum amount memory that SQL Server Memory Manager can allocate to the SQL Server process. Possible values are between 0 and 2147483647 Defaults to 0.
  })
  default  = null
  nullable = true
  validation {
    condition     = var.mssql_vm_sql_instance != null ? (var.mssql_vm_sql_instance.max_dop >= 0 && var.mssql_vm_sql_instance.max_dop <= 32767) : true
    error_message = "max_dop must be between 0 and 32767."
  }

  validation {
    condition     = var.mssql_vm_sql_instance != null ? (var.mssql_vm_sql_instance.max_server_memory_mb >= 128 && var.mssql_vm_sql_instance.max_server_memory_mb <= 2147483647) : true
    error_message = "max_server_memory_mb must be between 128 and 2147483647."
  }

  validation {
    condition     = var.mssql_vm_sql_instance != null ? (var.mssql_vm_sql_instance.min_server_memory_mb >= 0 && var.mssql_vm_sql_instance.min_server_memory_mb <= 2147483647) : true
    error_message = "min_server_memory_mb must be between 0 and 2147483647."
  }

  validation {
    condition     = var.mssql_vm_sql_instance != null ? var.mssql_vm_sql_instance.max_server_memory_mb >= var.mssql_vm_sql_instance.min_server_memory_mb : true
    error_message = "max_server_memory_mb must be greater than or equal to min_server_memory_mb."
  }
}

variable "mssql_vm_key_vault_credential" {
  description = "Key Vault Credential for Key Vault Credential Name, Key Vault URL, Service Principal Name and Service Principal Secret"
  type = list(object({
    key_vault_credential_name = string //(Required) The credential name.
    key_vault_url             = string //(Required) The Azure Key Vault url. Changing this forces a new resource to be created.
    service_principal_name    = string //(Required) The service principal name to access key vault. 
    service_principal_secret  = string //(Required) The service principal name secret to access key vault.
  }))
  default = []
}

variable "mssql_vm_auto_patching" {
  description = "Auto Patching for the day of week to apply the patch on, The Hour in the Virtual Machine Time-Zone when the patching maintenance window should begin and The size of the Maintenance Window in minutes."
  type = list(object({
    day_of_week                            = optional(string) //(Required) The day of week to apply the patch on. Possible values are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday and Sunday.
    maintenance_window_starting_hour       = optional(number) //(Required) The Hour, in the Virtual Machine Time-Zone when the patching maintenance window should begin.
    maintenance_window_duration_in_minutes = optional(number) //(Required) The size of the Maintenance Window in minutes.
  }))
  default = []
  validation {
    condition     = can(var.mssql_vm_auto_patching[0].day_of_week) ? contains(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], var.mssql_vm_auto_patching[0].day_of_week) : true
    error_message = "day_of_week in Auto Patching must be one of: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday."
  }
}

variable "mssql_vm_auto_backup" {
  description = "Auto backup for encryption password, manual schedule, retention period, storage blob endpoint, storage account access key and system databases backup enabled or not."

  type = list(object({
    encryption_password             = optional(string) //(Optional) Encryption password to use. Setting a password will enable encryption.
    retention_period_in_days        = optional(number) //(Required) Retention period of backups, in days. Valid values are from 1 to 30.
    storage_blob_endpoint           = optional(string) //(Required) Blob endpoint for the storage account where backups will be kept.
    storage_account_access_key      = optional(string) //(Required) Access key for the storage account where backups will be kept.
    system_databases_backup_enabled = optional(bool)   //(Optional) Include or exclude system databases from auto backup.
    manual_schedule = optional(list(object({
      full_backup_frequency           = string                     //(Required) Frequency of full backups. Valid values include Daily or Weekly.
      full_backup_start_hour          = number                     //(Required) Start hour of a given day during which full backups can take place. Valid values are from 0 to 23.
      full_backup_window_in_hours     = number                     // (Required) Duration of the time window of a given day during which full backups can take place, in hours. Valid values are between 1 and 23.
      log_backup_frequency_in_minutes = number                     //(Required) Frequency of log backups, in minutes. Valid values are from 5 to 60.
      days_of_week                    = optional(list(string), []) //(Optional) A list of days on which backup can take place. Possible values are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday and Sunday
    })), [])
  }))

  default = []

  validation {
    condition = can(var.mssql_vm_auto_backup[0].retention_period_in_days) ? (var.mssql_vm_auto_backup[0].retention_period_in_days >= 1 &&
    var.mssql_vm_auto_backup[0].retention_period_in_days <= 30) : true
    error_message = "retention_period_in_days must be between 1 and 30."
  }

  validation {
    condition     = can(var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_frequency) ? contains(["Daily", "Weekly"], var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_frequency) : true
    error_message = "full_backup_frequency must be either Daily or Weekly."
  }

  validation {
    condition = can(var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_start_hour) ? (var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_start_hour >= 0 &&
    var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_start_hour <= 23) : true
    error_message = "full_backup_start_hour must be between 0 and 23."
  }

  validation {
    condition = can(var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_window_in_hours) ? (var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_window_in_hours >= 1 &&
    var.mssql_vm_auto_backup[0].manual_schedule[0].full_backup_window_in_hours <= 23) : true
    error_message = "full_backup_window_in_hours must be between 1 and 23."
  }

  validation {
    condition = can(var.mssql_vm_auto_backup[0].manual_schedule[0].log_backup_frequency_in_minutes) ? (var.mssql_vm_auto_backup[0].manual_schedule[0].log_backup_frequency_in_minutes >= 5 &&
    var.mssql_vm_auto_backup[0].manual_schedule[0].log_backup_frequency_in_minutes <= 60) : true
    error_message = "log_backup_frequency_in_minutes must be between 5 and 60."
  }

  validation {
    condition = can(var.mssql_vm_auto_backup[0].manual_schedule[0].days_of_week) ? alltrue([
      for d in var.mssql_vm_auto_backup[0].manual_schedule[0].days_of_week :
      contains(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], d)
    ]) : true
    error_message = "days_of_week must contain valid day names."
  }
}

variable "mssql_vm_assessment" {
  description = "Assessment configuration for SQL Virtual Machine - Should Assessment be enabled, Should Assessment be run immediately, and schedule configuration."

  type = list(object({
    enabled         = optional(bool, true)  //(Optional) Should Assessment be enabled? Defaults to true.
    run_immediately = optional(bool, false) // (Optional) Should Assessment be run immediately? Defaults to false.
    schedule = optional(list(object({
      weekly_interval    = optional(number) //(Optional) How many weeks between assessment runs. Valid values are between 1 and 6.
      monthly_occurrence = optional(number) //(Optional) How many months between assessment runs. Valid values are between 1 and 5.
      day_of_week        = string           //(Required) What day of the week the assessment will be run. Possible values are Friday, Monday, Saturday, Sunday, Thursday, Tuesday and Wednesday.
      start_time         = string           //(Required) What time the assessment will be run. Must be in the format HH:mm.
    })), [])
  }))

  default  = []
  nullable = true

  # Mutual exclusivity validation - either weekly_interval OR monthly_occurrence, not both
  validation {
    condition = can(var.mssql_vm_assessment[0].schedule[0]) ? (
      (can(var.mssql_vm_assessment[0].schedule[0].weekly_interval) && !can(var.mssql_vm_assessment[0].schedule[0].monthly_occurrence)) ||
      (!can(var.mssql_vm_assessment[0].schedule[0].weekly_interval) && can(var.mssql_vm_assessment[0].schedule[0].monthly_occurrence)) ||
      (!can(var.mssql_vm_assessment[0].schedule[0].weekly_interval) && !can(var.mssql_vm_assessment[0].schedule[0].monthly_occurrence))
    ) : true

    error_message = "Either weekly_interval or monthly_occurrence must be specified, but not both."
  }

  # Weekly interval range validation
  validation {
    condition = can(var.mssql_vm_assessment[0].schedule[0].weekly_interval) ? (var.mssql_vm_assessment[0].schedule[0].weekly_interval >= 1 &&
    var.mssql_vm_assessment[0].schedule[0].weekly_interval <= 6) : true

    error_message = "weekly_interval must be between 1 and 6."
  }

  # Monthly occurrence range validation
  validation {
    condition = can(var.mssql_vm_assessment[0].schedule[0].monthly_occurrence) ? (var.mssql_vm_assessment[0].schedule[0].monthly_occurrence >= 1 &&
    var.mssql_vm_assessment[0].schedule[0].monthly_occurrence <= 5) : true
    error_message = "monthly_occurrence must be between 1 and 5."
  }

  # Valid day_of_week
  validation {
    condition     = can(var.mssql_vm_assessment[0].schedule[0].day_of_week) ? contains(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], var.mssql_vm_assessment[0].schedule[0].day_of_week) : true
    error_message = "day_of_week must be one of: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday."
  }
}

variable "mssql_vm_wsfc_domain_credential" {
  description = "WSFC Domain Credential configuration - The account passwords for cluster bootstrap, cluster operator, and SQL service account."
  type = list(object({
    cluster_bootstrap_account_password = optional(string) //(Required) The account password used for creating cluster.
    cluster_operator_account_password  = optional(string) //(Required) The account password used for operating cluster.
    sql_service_account_password       = optional(string) //(Required) The account password under which SQL service will run on all participating SQL virtual machines in the cluster.
  }))
  default   = []
}
