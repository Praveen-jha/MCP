# locals.tf

locals {
  data_disks = {
    for i in range(var.db_data_number_of_disks) :
    "data${i}" => {
      name         = "vmd-${var.prefix}-${var.name}-data-disk-${i}"
      disk_type    = var.disk_sku
      size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_data_size_gb / var.db_data_number_of_disks) : var.db_data_size_gb
      iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_iops / var.db_data_number_of_disks), null) : try(var.db_data_iops, null)
      throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_throughput / var.db_data_number_of_disks), null) : try(var.db_data_throughput, null)
      caching      = var.db_data_disk_caching
      type_of_disk = "data"
      lun          = i + 1
    }
  }

  log_disks = {
    for i in range(var.db_log_number_of_disks) :
    "log${i}" => {
      name         = "vmd-${var.prefix}-${var.name}-log-disk-${i}"
      disk_type    = var.disk_sku
      size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_log_size_gb / var.db_log_number_of_disks) : var.db_log_size_gb
      iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_iops / var.db_log_number_of_disks), null) : try(var.db_log_iops, null)
      throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_throughput / var.db_log_number_of_disks), null) : try(var.db_log_throughput, null)
      caching      = var.db_log_disk_caching
      type_of_disk = "log"
      lun          = i + var.db_data_number_of_disks + 1
    }
  }

  dynamic_disks_config = merge(local.data_disks, local.log_disks)

  dynamic_disk_luns = {
    data = [
      for disk_key, disk in local.dynamic_disks_config : azurerm_virtual_machine_data_disk_attachment.data_log_disk_attachment[disk_key].lun
      if disk.type_of_disk == "data"
    ]
    log = [
      for disk_key, disk in local.dynamic_disks_config : azurerm_virtual_machine_data_disk_attachment.data_log_disk_attachment[disk_key].lun
      if disk.type_of_disk == "log"
    ]
  }
}
