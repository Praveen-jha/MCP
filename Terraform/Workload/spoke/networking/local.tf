
locals {

  location_primary = "Qatar Central"
  //The map defined below is for Virtual Machine
  //Add or remove Virtual Machine objects defined in the map as per the deployment requiremets.
  //The object attributes are defined as - 
  # objectname = {
  #     nic_name                      = Name of the NIC attatched to this VM
  #     nic_ip_config_name            = Name of the NIC IP Config
  #     private_ip_address_allocation = Allocation type of Private IP
  #     vm_name                       = Name of the VM on Azure Portal
  #     vm_size                       = Size of the VM
  #     vm_zone                       = Zone in which VM is deployed
  #     admin_username                = Default admin username (Should be changed after the creation of the VM)
  #     os_disk_name                 = Name of the OS disk
  #     os_disk_caching              = Caching for the VM
  #     os_disk_storage_account_type = Type of the os disk neeted to be attatched to this machine, Example - Premium_LRS (maps to P series disk on Azure Portal)
  #     os_disk_disk_size_gb         = size of the os disk needed to be attatched to this machine, Example - 128
  #     source_image_id              = Location of the image
  # }
  virtual_machine = {
    self_hosted_integration_runtime_vm = {
      nic_name                      = "nic-${var.self_hosted_integration_runtime_vm.vm_name}"
      nic_ip_config_name            = "${var.self_hosted_integration_runtime_vm.vm_name}-ip_config"
      private_ip_address_allocation = "Dynamic"
      vm_name                       = var.self_hosted_integration_runtime_vm.vm_name
      vm_size                       = var.self_hosted_integration_runtime_vm.vm_size
      vm_zone                       = var.self_hosted_integration_runtime_vm.availability_zone
      admin_username                = var.self_hosted_integration_runtime_vm.admin_username
      os_disk_name                  = "osdisk-${var.self_hosted_integration_runtime_vm.vm_name}"
      os_disk_caching               = "ReadWrite"
      os_disk_storage_account_type  = "Standard_LRS"
      os_disk_disk_size_gb          = "128"
      source_image_id               = var.source_image_id
    }

    self_hosted_integration_runtime_vm_2 = {
      nic_name                      = "nic-${var.self_hosted_integration_runtime_vm_2.vm_name}"
      nic_ip_config_name            = "${var.self_hosted_integration_runtime_vm_2.vm_name}-ip_config"
      private_ip_address_allocation = "Dynamic"
      vm_name                       = var.self_hosted_integration_runtime_vm_2.vm_name
      vm_size                       = var.self_hosted_integration_runtime_vm_2.vm_size
      vm_zone                       = var.self_hosted_integration_runtime_vm_2.availability_zone
      admin_username                = var.self_hosted_integration_runtime_vm_2.admin_username
      os_disk_name                  = "osdisk-${var.self_hosted_integration_runtime_vm_2.vm_name}"
      os_disk_caching               = "ReadWrite"
      os_disk_storage_account_type  = "Standard_LRS"
      os_disk_disk_size_gb          = "128"
      source_image_id               = var.source_image_id
    }

    on_premises_data_gateway_vm = {
      nic_name                      = "nic-${var.on_premises_data_gateway_vm.vm_name}"
      nic_ip_config_name            = "${var.on_premises_data_gateway_vm.vm_name}-ip_config"
      private_ip_address_allocation = "Dynamic"
      vm_name                       = var.on_premises_data_gateway_vm.vm_name
      vm_size                       = var.on_premises_data_gateway_vm.vm_size
      vm_zone                       = var.on_premises_data_gateway_vm.availability_zone
      admin_username                = var.on_premises_data_gateway_vm.admin_username
      os_disk_name                  = "osdisk-${var.on_premises_data_gateway_vm.vm_name}"
      os_disk_caching               = "ReadWrite"
      os_disk_storage_account_type  = "Standard_LRS"
      os_disk_disk_size_gb          = "128"
      source_image_id               = var.source_image_id
    }

    on_premises_data_gateway_vm_2 = {
      nic_name                      = "nic-${var.on_premises_data_gateway_vm_2.vm_name}"
      nic_ip_config_name            = "${var.on_premises_data_gateway_vm_2.vm_name}-ip_config"
      private_ip_address_allocation = "Dynamic"
      vm_name                       = var.on_premises_data_gateway_vm_2.vm_name
      vm_size                       = var.on_premises_data_gateway_vm_2.vm_size
      vm_zone                       = var.on_premises_data_gateway_vm_2.availability_zone
      admin_username                = var.on_premises_data_gateway_vm_2.admin_username
      os_disk_name                  = "osdisk-${var.on_premises_data_gateway_vm_2.vm_name}"
      os_disk_caching               = "ReadWrite"
      os_disk_storage_account_type  = "Standard_LRS"
      os_disk_disk_size_gb          = "128"
      source_image_id               = var.source_image_id
    }
  }
}
