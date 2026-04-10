locals {

  rg_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-workload-rg"

  windows_vm_name = {
    for vm_key, vm_value in var.windows_vm_configs :
    vm_key => "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-${vm_key}"
  }

}
