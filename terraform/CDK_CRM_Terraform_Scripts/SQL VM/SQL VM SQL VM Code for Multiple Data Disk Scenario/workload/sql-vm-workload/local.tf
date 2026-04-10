# locals.tf
locals {
  # Naming convention locals
  base_name1                = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"
  network_interface_name    = "nic1-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  nic_ip_configuration_name = "ipconfig1-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"

  # Generate the map for data disks
  data_disks = {
    for i in range(var.sql_disks_simplified_config.data.number_of_disks) :
    "data${i+1}" => {
      name         = try(var.sql_disks_simplified_config.data.names[i], "data-disk-${i+1}")
      disk_type    = var.sql_disks_simplified_config.data.disk_type
      size_gb      = ceil(var.sql_disks_simplified_config.data.total_size_gb / var.sql_disks_simplified_config.data.number_of_disks)
      iops         = ceil(var.sql_disks_simplified_config.data.iops / var.sql_disks_simplified_config.data.number_of_disks)
      throughput   = ceil(var.sql_disks_simplified_config.data.throughput / var.sql_disks_simplified_config.data.number_of_disks)
      caching      = var.sql_disks_simplified_config.data.caching
      type_of_disk = "data"
      lun          = i
      zone         = var.sql_disks_simplified_config.data.zone
    }
  }

  # Generate the map for log disks
  log_disks = {
    for i in range(var.sql_disks_simplified_config.log.number_of_disks) :
    "log${i+1}" => {
      name         = try(var.sql_disks_simplified_config.log.names[i], "log-disk-${i+1}")
      disk_type    = var.sql_disks_simplified_config.log.disk_type
      size_gb      = ceil(var.sql_disks_simplified_config.log.total_size_gb / var.sql_disks_simplified_config.log.number_of_disks)
      iops         = ceil(var.sql_disks_simplified_config.log.iops / var.sql_disks_simplified_config.log.number_of_disks)
      throughput   = ceil(var.sql_disks_simplified_config.log.throughput / var.sql_disks_simplified_config.log.number_of_disks)
      caching      = var.sql_disks_simplified_config.log.caching
      type_of_disk = "log"
      lun          = i + var.sql_disks_simplified_config.data.number_of_disks
      zone         = var.sql_disks_simplified_config.log.zone
    }
  }

  # Generate the map for tempdb disks
  tempdb_disks = {
    for i in range(var.sql_disks_simplified_config.tempdb.number_of_disks) :
    "tempdb${i+1}" => {
      name         = try(var.sql_disks_simplified_config.tempdb.names[i], "tempdb-disk-${i+1}")
      disk_type    = var.sql_disks_simplified_config.tempdb.disk_type
      size_gb      = ceil(var.sql_disks_simplified_config.tempdb.total_size_gb / var.sql_disks_simplified_config.tempdb.number_of_disks)
      iops         = ceil(var.sql_disks_simplified_config.tempdb.iops / var.sql_disks_simplified_config.tempdb.number_of_disks)
      throughput   = ceil(var.sql_disks_simplified_config.tempdb.throughput / var.sql_disks_simplified_config.tempdb.number_of_disks)
      caching      = var.sql_disks_simplified_config.tempdb.caching
      type_of_disk = "tempdb"
      lun          = i + var.sql_disks_simplified_config.data.number_of_disks + var.sql_disks_simplified_config.log.number_of_disks
      zone         = var.sql_disks_simplified_config.tempdb.zone
    }
  }

  # Combine all the individual disk maps into a single `sql_disks_config` map
  sql_disks_config = merge(local.data_disks, local.log_disks, local.tempdb_disks)

  # Generate the LUN lists based on the disk type from the `data_disk_attachment` module outputs.
  data_disk_luns = [
    for disk_key, disk in local.sql_disks_config : module.data_disk_attachment[disk_key].lun
    if disk.type_of_disk == "data"
  ]

  log_disk_luns = [
    for disk_key, disk in local.sql_disks_config : module.data_disk_attachment[disk_key].lun
    if disk.type_of_disk == "log"
  ]

  tempdb_disk_luns = [
    for disk_key, disk in local.sql_disks_config : module.data_disk_attachment[disk_key].lun
    if disk.type_of_disk == "tempdb"
  ]

  # The rest of the locals block remains the same
  final_mssql_vm_storage_configuration = {
    disk_type                      = var.sql_vm_storage_configuration.disk_type
    storage_workload_type          = var.sql_vm_storage_configuration.storage_workload_type
    system_db_on_data_disk_enabled = var.sql_vm_storage_configuration.system_db_on_data_disk_enabled
    data_settings = merge(
      var.sql_vm_storage_configuration.data_settings,
      { luns = local.data_disk_luns }
    )
    log_settings = merge(
      var.sql_vm_storage_configuration.log_settings,
      { luns = local.log_disk_luns }
    )
    temp_db_settings = merge(
      var.sql_vm_storage_configuration.temp_db_settings,
      { luns = local.tempdb_disk_luns }
    )
  }
}