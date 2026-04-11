locals {

  resource_group_name      = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location                 = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location
  hub_comp_rg_name         = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
  compute_subnet_name      = "ict-platform-shrd-hub-comp-snet-uaen-01"
  hub_network_rg_name      = "ict-platform-shrd-hub-network-rg-uaen-01"
  hub_virtual_network_name = "${var.tenant_name}-platform-${var.environment}-vnet-${var.location_shortname}-01"
  data_disks_name = ["${var.tenant_name}-platform-${var.environment}-mgdisk-${var.location_shortname}-01"]

   windows_vm_name = {
    for vm_key, vm_value in var.windows_vm_configs :
    vm_key => "${var.tenant_name}-platform-${var.environment}-${vm_value.vm_workload_type}-vm-${var.location_shortname}-${vm_value.instance_number}"
  }

  linux_vm_name = {
    for vm_key, vm_value in var.linux_vm_configs :
    vm_key => "${var.tenant_name}-platform-${var.environment}-${vm_value.vm_workload_type}-vm-${var.location_shortname}-${vm_value.instance_number}"
  }
}
 
 