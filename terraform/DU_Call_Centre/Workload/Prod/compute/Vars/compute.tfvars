location                   = "UAE North"
tenant_name                = "ict"
bu_name                    = "cog"
compute_subnet_name        = "ict-platform-cog-prd-comp-snet-uaen-01"
virtual_network_name       = "ict-platform-cog-prd-vnet-uaen-01"
subnet_resource_group_name = "ict-platform-cog-prd-network-rg-uaen-01"

shutdown_timezone                = "UTC"
shutdown_notification_enabled    = false
daily_recurrence_time            = "1430"
auto_shutdown_notification_email = "aarishahmed.siddique@celebaltech.com"
identity_type                    = "UserAssigned"

tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Shared"
  "Environment Type"   = "Cognitive Services"
  "Architecture Type"  = "IaaS"
}

# key_vault_rg_name = "ict-platform-ccai-ai-rg"
# key_vault_name    = "ict-platform-ccai-kv"

# ================================
# use the below windows_vm_configs block to pass VM variable values. 
# Note: VM Name will get create using Locals block "${var.tenant_name}-platform-${var.bu_name}-${vm_key} || vm_key get from below map(object) key value.
# Example: ict-platform-cognitive-devopssha01-vm
# ================================

windows_vm_configs = {
  sha-vm = { #VM name get create using local value "${var.tenant_name}-platform-${var.bu_name}-${vm_key} + devopssha01-vm
    size                               = "Standard_D4s_v5"
    windows_sku                        = "2022-Datacenter"
    windows_offer                      = "WindowsServer"
    windows_publisher                  = "MicrosoftWindowsServer"
    admin_username                     = "duadminuser"
    computer_name                      = "ictcogsha01"
    password                           = "R,QdwK?Z.iId"
    caching                            = "ReadWrite"
    storage_account_type               = "StandardSSD_LRS"
    image_version                      = "latest"
    IP_allocation_method               = "Static"
    private_ip_address_allocation      = "Dynamic"
    nic_accelerated_networking_enabled = "true"
    auto_shutdown_enable               = "true"
    identity_type                      = "SystemAssigned"
    vm_tags = {
      "Workload Name" = "DevOpsSHA-VirtualMachine"
      "Tier"          = "Compute"
    }
    nic_tags = {
      "Workload Name" = "DevOpsSHA-VirtualMachineNIC"
      "Tier"          = "Networking"
    }
  }
}
