#Local Block for Resource Naming Conventions
locals {
  rg_name              = var.nameConfig.rg_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group[0].name
  virtual_network_name = var.nameConfig.vnet_creation == "new" ? module.virtual_network[0].virtual_network_name : data.azurerm_virtual_network.existing_vnet[0].name

  base_name1 = "${var.nameConfig.short_name}-${var.nameConfig.product_name}-${var.nameConfig.environment}"

  new_resource_group_name   = "rg-${local.base_name1}-${var.nameConfig.region_flag}-${var.nameConfig.instance}"
  new_virtual_network_name  = "vnet-${local.base_name1}-${var.nameConfig.region_flag}-${var.nameConfig.instance}"
  new_subnet_name           = "snet-${local.base_name1}-${var.nameConfig.application}-${var.nameConfig.region_flag}-${var.nameConfig.instance}"
  new_compute_nsg_name      = "nsg-${local.base_name1}-${var.nameConfig.application}-${var.nameConfig.region_flag}-${var.nameConfig.instance}"
  vm_name                   = "sqlvm-${local.base_name1}-${var.nameConfig.region_flag}-${var.nameConfig.instance}"
  network_interface_name    = "nic-${local.base_name1}-${var.nameConfig.application}-${var.nameConfig.region_flag}-${var.nameConfig.instance}"
  nic_ip_configuration_name = "ipconfig-${local.base_name1}-${var.nameConfig.application}-${var.nameConfig.region_flag}-${var.nameConfig.instance}"
  computer_name             = "sqlvd${var.nameConfig.short_name}${var.nameConfig.product_name}${var.nameConfig.environment}${var.nameConfig.instance}"

  data_disks_name = ["disk-${local.base_name1}-${var.nameConfig.application}-${var.nameConfig.region_flag}-01",
    "disk-${local.base_name1}-${var.nameConfig.application}-${var.nameConfig.region_flag}-02",
    "disk-${local.base_name1}-${var.nameConfig.application}-${var.nameConfig.region_flag}-03"
  ]

  subnet_delegation_null = {}
  service_endpoints      = null
}
