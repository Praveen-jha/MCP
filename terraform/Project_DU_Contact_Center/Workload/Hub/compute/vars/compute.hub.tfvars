location                   = "UAE North"
tenant_name                = "ict"
environment                = "shrd-hub"
compute_subnet_name        = "ict-platform-ccai-hub-compute-snet-uaen"
virtual_network_name       = "ict-platform-shrd-hub-vnet-uaen-01"
subnet_resource_group_name = "ict-platform-shrd-hub-network-rg-uaen-01"

subscription_id                  = "0207aa1d-1c80-483b-9e70-960963c72cda"
shutdown_timezone                = "UTC"
shutdown_notification_enabled    = false
daily_recurrence_time            = "1430"
auto_shutdown_notification_email = "aarishahmed.siddique@celebaltech.com"

workload_type      = "compute"
rg_location        = "UAE North"
rg_creation        = "new"
location_shortname = "uaen"
resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Compute"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}

# key_vault_rg_name = "ict-platform-ccai-dev-data-rg"
# key_vault_name    = "ict-ccai-dev-data-kv"

#================================
# use the below windows_vm_configs block to pass VM variable values.
# Note: VM Name will get create using Locals block ${var.tenant_name}-platform-${var.bu_name}-${var.environment}-${vm_key} || vm_key get from below map(object) key value.
# Example: ict-plt-ccai-devopssha01-vm
#================================

windows_vm_configs = {
  devopssha01 = { #DevOps_SHA_VM
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    password                           = "1)z*yj9M+<rpI9+q"
    computer_name                      = "icthubsha01"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "01"
    vm_workload_type                   = "sha"
    vm_tags = {
      "Workload Name"      = "SHA-VirtualMachine"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
    nic_tags = {
      "Workload Name"      = "SHA-VirtualMachineNIC"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
  }
  devopssha02-vm = { #DevOps_SHA_VM
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    password                           = "1)z*yj9M+<rpI9-p"
    computer_name                      = "icthubsha02"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "02"
    vm_workload_type                   = "sha"
    vm_tags = {
      "Workload Name"      = "SHA-VirtualMachine"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
    nic_tags = {
      "Workload Name"      = "SHA-VirtualMachineNIC"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
  }
  jumpbox01-vm = { #Jumpbox01_VM_For_Development.
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    password                           = "_&M<tj4XK<>V0mJm"
    computer_name                      = "icthubjb01"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "01"
    vm_workload_type                   = "jumpbox"
    vm_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachine"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
    nic_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachineNIC"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
  }
  jumpbox02-vm = { #Jumpbox02_VM_For_Devlopment.
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    password                           = "L+ozMiBR{76q5eud"
    computer_name                      = "icthubjb02"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "02"
    vm_workload_type                   = "jumpbox"
    vm_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachine"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
    nic_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachineNIC"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
  }
  jumpbox03-vm = { #Jumpbox03_VM_For_Devlopment.
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    password                           = "nY3hYABxjKe@:Hoh"
    computer_name                      = "icthubjb03"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "03"
    vm_workload_type                   = "jumpbox"
    vm_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachine"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
    nic_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachineNIC"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
  }
  jumpbox04-vm = { #Jumpbox04_VM_For_Devlopment.
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    password                           = "1PAqqB}row77@&]B"
    computer_name                      = "icthubjb04"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "04"
    vm_workload_type                   = "jumpbox"
    vm_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachine"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
    nic_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachineNIC"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
  }
  jumpbox05-vm = { #Jumpbox05_VM_For_Devlopment.
    size                               = "Standard_D4s_v5"
    windows_sku                        = "win11-22h2-avd"
    windows_offer                      = "windows-11"
    windows_publisher                  = "MicrosoftWindowsDesktop"
    admin_username                     = "duadminuser"
    password                           = "1PAqqB}row77@&]C"
    computer_name                      = "icthubjb05"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "05"
    vm_workload_type                   = "jumpbox"
    vm_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachine"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
    }
    nic_tags = {
      "Workload Name"      = "Jumpbox-VirtualMachineNIC"
      "Tier"               = "Compute"
      "Workload Category"  = "Internal Workloads"
      "Business Unit Code" = "DPS"
      "Workload Architype" = "Internal Platform"
      "Environment"        = "Hub"
      "Environment Type"   = "Hub"
      "Architecture Type"  = "IaaS"
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

linux_vm_configs = {
  development-vm = { #Linux_VM 
    size                               = "Standard_D16s_v5"
    linux_sku                          = "22_04-lts"
    linux_offer                        = "0001-com-ubuntu-server-jammy"
    linux_publisher                    = "Canonical"
    admin_username                     = "duadminuser"
    computer_name                      = "ictccailinux01" #ict-plt-ccai-dev-devopssha01-vm
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    disk_size_gb                       = 512
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "false"
    disable_password_authentication    = "false"
    vm_identity_type                   = "SystemAssigned"
    instance_number                    = "01"
    vm_workload_type                   = "linux"

    vm_tags = {
      "Workload Name" = "Development-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "DevOpsSHA-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
}

# Configuration for managed disk resources created separately
dataDiskResources = [
  {
    sku = "Standard_LRS"
    properties = {
      createOption = "Empty"
      diskSizeGB   = 512
    }
  }
]
