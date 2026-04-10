location                   = "UAE North"
tenant_name                = "ict"
environment                = "dev"
bu_name                    = "ccai"
compute_subnet_name        = "ict-platform-ccai-dev-compute-snet-uaen"
virtual_network_name       = "ict-platform-ccai-dev-vnet-uaen"
subnet_resource_group_name = "ict-platform-ccai-dev-network-rg"
subscription_id            = "17f94bdc-8e26-45b1-9650-fb88217dd273"

shutdown_timezone                = "UTC"
shutdown_notification_enabled    = false
daily_recurrence_time            = "1430"
auto_shutdown_notification_email = "aarishahmed.siddique@celebaltech.com"

tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Non Production"
  "Architecture Type"  = "IaaS"
}

key_vault_rg_name = "ict-platform-ccai-dev-data-rg"
key_vault_name    = "ict-ccai-dev-data-kv"

#================================
# use the below windows_vm_configs block to pass VM variable values. 
# Note: VM Name will get create using Locals block ${var.tenant_name}-platform-${var.bu_name}-${var.environment}-${vm_key} || vm_key get from below map(object) key value.
# Example: ict-plt-ccai-devopssha01-vm
#================================

windows_vm_configs = {
  devopssha01-vm = { #DevOps_SHA_VM 
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    computer_name                      = "ictccaidevsha01" #ict-plt-ccai-dev-devopssha01-vm
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "true"
    vm_identity_type                   = "SystemAssigned"
    vm_tags = {
      "Workload Name" = "DevOpsSHA-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "DevOpsSHA-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
  jumpbox01-vm = { #Jumpbox01_VM_For_Devlopment. 
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    computer_name                      = "ictccaidevjb01" #ict-plt-ccai-dev-jumpbox01-vm
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "true"
    vm_identity_type                   = "SystemAssigned"
    vm_tags = {
      "Workload Name" = "Jumpbox-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "Jumpbox-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
  jumpbox02-vm = { #Jumpbox02_VM_For_Devlopment. 
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    computer_name                      = "ictccaidevjb02" #ict-plt-ccai-dev-jumpbox02-vm
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "true"
    vm_identity_type                   = "SystemAssigned"
    vm_tags = {
      "Workload Name" = "Jumpbox-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "Jumpbox-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
  jumpbox03-vm = { #Jumpbox03_VM_For_Devlopment. 
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    computer_name                      = "ictccaidevjb03" #ict-plt-ccai-dev-jumpbox03-vm
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "true"
    vm_identity_type                   = "SystemAssigned"
    vm_tags = {
      "Workload Name" = "Jumpbox-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "Jumpbox-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
  jumpbox04-vm = { #Jumpbox04_VM_For_Devlopment. 
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    computer_name                      = "ictccaidevjb04" #ict-plt-ccai-dev-jumpbox04-vm
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "true"
    vm_identity_type                   = "SystemAssigned"
    vm_tags = {
      "Workload Name" = "Jumpbox-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "Jumpbox-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
  jumpbox05-vm = { #Jumpbox04_VM_For_Devlopment. 
    size                               = "Standard_D4s_v5"
    windows_sku                        = "win11-22h2-avd"
    windows_offer                      = "windows-11"
    windows_publisher                  = "MicrosoftWindowsDesktop"
    admin_username                     = "duadminuser"
    computer_name                      = "ictccaidevjb05" #ict-plt-ccai-dev-jumpbox05-vm
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "true"
    vm_identity_type                   = "SystemAssigned"
    vm_tags = {
      "Workload Name" = "Jumpbox-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "Jumpbox-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
}
# fabricodgw01-vm = { #Fabric on-prem Data Gateway
#   size                               = "Standard_D4s_v5"
#   windows_sku                        = "2022-Datacenter"
#   windows_offer                      = "WindowsServer"
#   windows_publisher                  = "MicrosoftWindowsServer"
#   admin_username                     = "duadminuser"
#   computer_name                      = "ictpltccaiafabricodgwvm"   #ict-plt-ccai-dev-adfshir-vm
#   caching                            = "ReadWrite"
#   storage_account_type               = "StandardSSD_LRS"
#   image_version                      = "latest"
#   IP_allocation_method               = "Static"
#   private_ip_address_allocation      = "Dynamic"
#   nic_accelerated_networking_enabled = "true"
#   auto_shutdown_enable               = "false"
#   vm_identity_type                   = "SystemAssigned"
#   vm_tags = {
#     "Workload Name" = "FabricOdgw01-VirtualMachine"
#     "Tier"          = "Compute"
#   }
#   nic_tags = {
#     "Workload Name" = "FabricOdgw01-VirtualMachineNIC"
#     "Tier"          = "Networking"
#   }
# }
