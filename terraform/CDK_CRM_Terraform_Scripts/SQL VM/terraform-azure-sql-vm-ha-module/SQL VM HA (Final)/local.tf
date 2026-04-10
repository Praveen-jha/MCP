# locals.tf

locals {
  replica_instances = { for i in range(var.number_of_replicas) : "instance-${i}" => i }
  replica_zones_map = { for k, v in local.replica_instances : k => var.vm_zones[v] }
  
  data_disk_combinations = setproduct(keys(local.replica_instances), range(var.db_data_number_of_disks))
  log_disk_combinations  = setproduct(keys(local.replica_instances), range(var.db_log_number_of_disks))
  
  all_data_disks_config = {
    for item in local.data_disk_combinations : "${item[0]}-data-${item[1]}" => {
      vm_key       = item[0]
      # CHANGE: Use the numerical index from replica_instances to look up the name in the list.
      name         = "vmd-${var.prefix}-${var.name[local.replica_instances[item[0]]]}-data-disk-${item[1] + 1}"
      disk_type    = var.disk_sku
      size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_data_size_gb / var.db_data_number_of_disks) : var.db_data_size_gb
      iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_iops / var.db_data_number_of_disks), null) : try(var.db_data_iops, null)
      throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_throughput / var.db_data_number_of_disks), null) : try(var.db_data_throughput, null)
      caching      = var.db_data_disk_caching
      type_of_disk = "data"
      lun          = item[1] + 1
    }
  }

  all_log_disks_config = {
    for item in local.log_disk_combinations : "${item[0]}-log-${item[1]}" => {
      vm_key       = item[0]
      # CHANGE: Use the numerical index from replica_instances to look up the name in the list.
      name         = "vmd-${var.prefix}-${var.name[local.replica_instances[item[0]]]}-log-disk-${item[1] + 1}"
      disk_type    = var.disk_sku
      size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_log_size_gb / var.db_log_number_of_disks) : var.db_log_size_gb
      iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_iops / var.db_log_number_of_disks), null) : try(var.db_log_iops, null)
      throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_throughput / var.db_log_number_of_disks), null) : try(var.db_log_throughput, null)
      caching      = var.db_log_disk_caching
      type_of_disk = "log"
      lun          = item[1] + var.db_data_number_of_disks + 1
    }
  }

  dynamic_disks_config = merge(local.all_data_disks_config, local.all_log_disks_config)

  dynamic_disk_luns = {
    for vm_key in keys(local.replica_instances) : vm_key => {
      data = [
        for disk_key, disk in local.dynamic_disks_config : disk.lun
        if disk.type_of_disk == "data" && disk.vm_key == vm_key
      ]
      log = [
        for disk_key, disk in local.dynamic_disks_config : disk.lun
        if disk.type_of_disk == "log" && disk.vm_key == vm_key
      ]
    }
  }
}

locals {
  replica_peers = {
    for this_key, this_index in local.replica_instances :
    this_key => [
      for other_key, other_index in local.replica_instances :
      {
        name        = "AGNode${other_index + 1}"
        cert        = "AGNode${other_index + 1}Cert"
        login       = "AGNode${other_index + 1}_Login"
        user        = "AGNode${other_index + 1}_User"
        ip          = azurerm_windows_virtual_machine.this[other_key].private_ip_address
      }
      if other_key != this_key
    ]
  }
}

locals {
  sql_peer_script_blocks = {
    for key, peers in local.replica_peers : key => join("\n", [
      for peer in peers : <<-EOT
        # ---- Peer:
        Copy-Item "\\${peer.ip}\\AGfolder\\${peer.cert}.crt" -Destination "C:\\AGfolder\\" -Force

        # $sql = @"
        # USE master;
        # CREATE LOGIN ${peer.login} WITH PASSWORD = 'PassWord123!';
        # CREATE USER ${peer.user} FOR LOGIN ${peer.login};
        # CREATE CERTIFICATE ${peer.cert}
        #   AUTHORIZATION ${peer.user}
        #   FROM FILE = 'C:\\AGfolder\\${peer.cert}.crt';
        # GRANT CONNECT ON ENDPOINT::hadr_endpoint TO [${peer.login}];
        # "@

        # sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $sql
      EOT
    ])
  }
}


locals {
  replica_ips = [
    for key in keys(local.replica_instances) :
    azurerm_windows_virtual_machine.this[key].private_ip_address
  ]
}

# locals {
#   replica_instances = { for i in range(var.number_of_replicas) : "instance-${i}" => i }
  
#   data_disk_combinations = setproduct(keys(local.replica_instances), range(var.db_data_number_of_disks))
#   log_disk_combinations  = setproduct(keys(local.replica_instances), range(var.db_log_number_of_disks))
  
#   all_data_disks_config = {
#     for item in local.data_disk_combinations : "${item[0]}-data-${item[1]}" => {
#       vm_key       = item[0]
#       name         = "vmd-${var.prefix}-${var.name}-${local.replica_instances[item[0]]}-data-disk-${item[1]}"
#       disk_type    = var.disk_sku
#       size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_data_size_gb / var.db_data_number_of_disks) : var.db_data_size_gb
#       iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_iops / var.db_data_number_of_disks), null) : try(var.db_data_iops, null)
#       throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_throughput / var.db_data_number_of_disks), null) : try(var.db_data_throughput, null)
#       caching      = var.db_data_disk_caching
#       type_of_disk = "data"
#       lun          = item[1] + 1
#     }
#   }

#   all_log_disks_config = {
#     for item in local.log_disk_combinations : "${item[0]}-log-${item[1]}" => {
#       vm_key       = item[0]
#       name         = "vmd-${var.prefix}-${var.name}-${local.replica_instances[item[0]]}-log-disk-${item[1]}"
#       disk_type    = var.disk_sku
#       size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_log_size_gb / var.db_log_number_of_disks) : var.db_log_size_gb
#       iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_iops / var.db_log_number_of_disks), null) : try(var.db_log_iops, null)
#       throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_throughput / var.db_log_number_of_disks), null) : try(var.db_log_throughput, null)
#       caching      = var.db_log_disk_caching
#       type_of_disk = "log"
#       lun          = item[1] + var.db_data_number_of_disks + 1
#     }
#   }

#   # Merged map for disk creation and attachment loops
#   dynamic_disks_config = merge(local.all_data_disks_config, local.all_log_disks_config)

#   dynamic_disk_luns = {
#     for vm_key in keys(local.replica_instances) : vm_key => {
#       data = [
#         for disk_key, disk in local.dynamic_disks_config : disk.lun
#         if disk.type_of_disk == "data" && disk.vm_key == vm_key
#       ]
#       log = [
#         for disk_key, disk in local.dynamic_disks_config : disk.lun
#         if disk.type_of_disk == "log" && disk.vm_key == vm_key
#       ]
#     }
#   }
# }

# locals {
#   # This map will drive the for_each loops, providing a unique key for each replica
#   replica_instances = { for i in range(var.number_of_replicas) : "instance-${i}" => i }
  
#   # --- Disk Configuration ---
#   # We need a flat map of ALL disks across ALL replicas.
#   # The key includes both the replica and disk number to ensure uniqueness.
#   all_data_disks_config = {
#     for vm_key, vm_index in local.replica_instances :
#    for i in range(var.db_log_number_of_disks) :
#     "${vm_key}-data-${i}" => { # This is the key => value pair the error is looking for
#       vm_key       = vm_key
#       name         = "vmd-${var.prefix}-${var.name}-${vm_index}-data-disk-${i}"
#       disk_type    = var.disk_sku
#       size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_data_size_gb / var.db_data_number_of_disks) : var.db_data_size_gb
#       iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_iops / var.db_data_number_of_disks), null) : try(var.db_data_iops, null)
#       throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_throughput / var.db_data_number_of_disks), null) : try(var.db_data_throughput, null)
#       caching      = var.db_data_disk_caching
#       type_of_disk = "data"
#       lun          = i + 1
#     }
#   }

#   all_log_disks_config = {
#     for vm_key, vm_index in local.replica_instances :
#     for i in range(var.db_log_number_of_disks) :
#     "${vm_key}-log-${i}" => { # This is the key => value pair
#       vm_key       = vm_key
#       name         = "vmd-${var.prefix}-${var.name}-${vm_index}-log-disk-${i}"
#       disk_type    = var.disk_sku
#       size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_log_size_gb / var.db_log_number_of_disks) : var.db_log_size_gb
#       iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_iops / var.db_log_number_of_disks), null) : try(var.db_log_iops, null)
#       throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_throughput / var.db_log_number_of_disks), null) : try(var.db_log_throughput, null)
#       caching      = var.db_log_disk_caching
#       type_of_disk = "log"
#       lun          = i + var.db_data_number_of_disks + 1
#     }
#   }

  
#   # Merged map for disk creation and attachment loops
#   dynamic_disks_config = merge(local.all_data_disks_config, local.all_log_disks_config)

#   # A map to easily get the LUNs for each VM's data and log disks
#   dynamic_disk_luns = {
#     for vm_key, vm_index in local.replica_instances : vm_key => {
#       data = [
#         for disk_key, disk in local.dynamic_disks_config : disk.lun
#         if disk.type_of_disk == "data" && disk.vm_key == vm_key
#       ]
#       log = [
#         for disk_key, disk in local.dynamic_disks_config : disk.lun
#         if disk.type_of_disk == "log" && disk.vm_key == vm_key
#       ]
#     }
#   }
# }

# locals {
#   data_disks = {
#     for i in range(var.db_data_number_of_disks) :
#     "data${i}" => {
#       name         = "vmd-${var.prefix}-${var.name}-data-disk-${i}"
#       disk_type    = var.disk_sku
#       size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_data_size_gb / var.db_data_number_of_disks) : var.db_data_size_gb
#       iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_iops / var.db_data_number_of_disks), null) : try(var.db_data_iops, null)
#       throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_data_throughput / var.db_data_number_of_disks), null) : try(var.db_data_throughput, null)
#       caching      = var.db_data_disk_caching
#       type_of_disk = "data"
#       lun          = i + 1
#     }
#   }

#   log_disks = {
#     for i in range(var.db_log_number_of_disks) :
#     "log${i}" => {
#       name         = "vmd-${var.prefix}-${var.name}-log-disk-${i}"
#       disk_type    = var.disk_sku
#       size_gb      = var.disk_sku == "PremiumV2_LRS" ? ceil(var.db_log_size_gb / var.db_log_number_of_disks) : var.db_log_size_gb
#       iops         = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_iops / var.db_log_number_of_disks), null) : try(var.db_log_iops, null)
#       throughput   = var.disk_sku == "PremiumV2_LRS" ? try(ceil(var.db_log_throughput / var.db_log_number_of_disks), null) : try(var.db_log_throughput, null)
#       caching      = var.db_log_disk_caching
#       type_of_disk = "log"
#       lun          = i + var.db_data_number_of_disks + 1
#     }
#   }

#   dynamic_disks_config = merge(local.data_disks, local.log_disks)

#   dynamic_disk_luns = {
#     data = [
#       for disk_key, disk in local.dynamic_disks_config : azurerm_virtual_machine_data_disk_attachment.data_log_disk_attachment[disk_key].lun
#       if disk.type_of_disk == "data"
#     ]
#     log = [
#       for disk_key, disk in local.dynamic_disks_config : azurerm_virtual_machine_data_disk_attachment.data_log_disk_attachment[disk_key].lun
#       if disk.type_of_disk == "log"
#     ]
#   }
# }
