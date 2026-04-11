locals {
  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  compute_rg_name               = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-workload-rg"
  sha_vm_name                   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-sha-vm"
  sha_network_interface_name    = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-sha-vm-nic"
  sha_nic_ip_configuration_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-sha-vm-nic-ipc"
  sha_computer_name             = "ictpltgtxshavm"

  development_vm_names = [
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-01",
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-02",
  ]
  development_vm_network_interface_names = [
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-nic-01",
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-nic-02"
  ]
  development_vm_nic_ip_configuration_names = [
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-nic-ipc-01",
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-nic-ipc-02"
  ]
  development_vm_computer_names = ["ictpltgtxdevvm1","ictpltgtxdevvm2"]

  caching                       = "ReadWrite"
  storage_account_type          = "StandardSSD_LRS"
  image_version                 = "latest"
  IP_allocation_method          = "Static"
  private_ip_address_allocation = "Dynamic"

}
