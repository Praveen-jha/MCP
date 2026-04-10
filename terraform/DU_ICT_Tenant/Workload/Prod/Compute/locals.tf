locals {
  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  compute_rg_name               = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-workload-rg"
  pbi_vm_name                   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pbi-vm-01"
  pbi_network_interface_name    = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pbi-vm-nic-01"
  pbi_nic_ip_configuration_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pbi-vm-nic-ipc-01"
  pbi_computer_name             = "ictplthrbpbivm"

  development_vm_names = [
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-01"
  ]
  development_vm_network_interface_names = [
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-nic-01"
  ]
  development_vm_nic_ip_configuration_names = [
    "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-devlopment-vm-nic-ipc-01"
  ]
  development_vm_computer_names = ["ictplthrbdevvm1"]

  caching                       = "ReadWrite"
  storage_account_type          = "StandardSSD_LRS"
  image_version                 = "latest"
  private_ip_address_allocation = "Dynamic"

}
