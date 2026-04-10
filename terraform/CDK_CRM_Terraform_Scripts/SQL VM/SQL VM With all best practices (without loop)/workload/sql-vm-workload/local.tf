#Local Block for Resource Naming Conventions
locals {
  base_name1 = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  network_interface_name    = "nic-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  nic_ip_configuration_name = "ipconfig-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"

  data_disk_for_each = {
    for key, data_disk_config in var.data_disk_resources : key => {
      data_disk_name          = data_disk_config.name
      data_disk_sku           = data_disk_config.sku
      data_disk_create_option = data_disk_config.properties.create_option
      data_disk_size_gb       = data_disk_config.properties.disk_sizegb
      data_disk_lun           = data_disk_config.properties.lun
      data_disk_caching       = data_disk_config.properties.caching
    }
  }

  virtual_machine_extension_settings = jsonencode({
    mdmId = ""
  })
}
