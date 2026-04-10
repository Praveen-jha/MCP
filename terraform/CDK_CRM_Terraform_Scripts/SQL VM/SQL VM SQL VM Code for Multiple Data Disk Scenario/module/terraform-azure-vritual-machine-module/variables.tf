// This file defines the input variables for the azurerm_windows_virtual_machine module.
#Variables for Network Interface Card
variable "network_interface_card_name" {
  description = "(Required) The name of the network interface card (NIC) for the virtual machine."
  type        = string
}

variable "network_interface_card_location" {
  description = "(Required) The Azure region where the Network Interface should exist."
  type        = string
}

variable "network_interface_card_rg_name" {
  description = "(Required) The name of the Resource Group in which to create the Network Interface."
  type        = string
}

variable "network_interface_card_ip_configuration_name" {
  description = "(Required) The name of the IP Configuration block for the Network Interface."
  type        = string
}

variable "network_interface_card_tags" {
  description = "(Optional) A mapping of tags to assign to the Network Interface."
  type        = map(string)
}

# Optional Variables
variable "network_interface_card_auxiliary_mode" {
  description = "Specifies the auxiliary mode used to enable high-performance networking on NVAs. (Preview feature)"
  type        = string
  default     = null

  validation {
    condition     = var.network_interface_card_auxiliary_mode != null ? contains(["AcceleratedConnections", "Floating", "MaxConnections", "None"], var.network_interface_card_auxiliary_mode) : true
    error_message = "auxiliary mode must be either 'AcceleratedConnections', 'Floating', 'MaxConnections', or 'None'."
  }
}

variable "network_interface_card_auxiliary_sku" {
  description = "Specifies the SKU used for high-performance network features on NVAs. (Preview feature)"
  type        = string
  default     = null

  validation {
    condition     = var.network_interface_card_auxiliary_sku != null ? contains(["A8", "A4", "A1", "A2", "None"], var.network_interface_card_auxiliary_sku) : true
    error_message = "auxiliary sku must be either 'A8', 'A4', 'A1', 'A2', or 'None'."
  }
}

variable "network_interface_card_dns_servers" {
  description = "A list of custom DNS servers to assign to the Network Interface. Overrides DNS settings from the virtual network."
  type        = list(string)
  default     = null
}

variable "network_interface_card_edge_zone" {
  description = "Specifies the Edge Zone within the Azure region where this network_interface_card should exist."
  type        = string
  default     = null
}

variable "network_interface_card_ip_forwarding_enabled" {
  description = "Whether IP forwarding should be enabled on the Network Interface. Defaults to false."
  type        = bool
  default     = false
}

variable "network_interface_card_accelerated_networking_enabled" {
  description = "Whether Accelerated Networking should be enabled. Only supported on specific VM sizes and clusters."
  type        = bool
  default     = false
}

variable "network_interface_card_internal_dns_name_label" {
  description = "The DNS name label for internal communications within the same virtual network."
  type        = string
  default     = null
}

variable "network_interface_card_subnet_id" {
  description = "The ID of the subnet where this NIC should be located. Required when private_ip_address_version is IPv4."
  type        = string
  default     = null
}

variable "network_interface_card_private_ip_address_allocation" {
  description = "(Required) The allocation method for the private IP. Possible values: Dynamic, Static."
  type        = string

  validation {
    condition     = contains(["Dynamic", "Static"], var.network_interface_card_private_ip_address_allocation)
    error_message = "Private IP Address Allocation must be either 'Dynamic', or 'Static'."
  }
}

variable "network_interface_card_private_ip_address_version" {
  description = "The IP version to use. Possible values: IPv4 or IPv6"
  type        = string
  default     = "IPv4"

  validation {
    condition     = contains(["IPv4", "IPv6"], var.network_interface_card_private_ip_address_version)
    error_message = "Private IP Address Version must be either 'IPv6', or 'IPv4'."
  }
}

variable "network_interface_card_gateway_load_balancer_frontend_ip_configuration_id" {
  description = "The frontend IP configuration ID of a Gateway SKU Load Balancer to associate with this NIC."
  type        = string
  default     = null
}

variable "network_interface_card_public_ip_address_id" {
  description = "The ID of a public IP address to associate with the NIC."
  type        = string
  default     = null
}

variable "network_interface_card_primary" {
  description = "Whether this is the primary IP configuration. Must be true for the first configuration when multiple exist."
  type        = bool
  default     = null
  nullable    = true
}

variable "network_interface_card_private_ip_address" {
  description = "The static IP address to use when allocation is set to Static."
  type        = string
  default     = null
}

// variables.tf
// This file defines the input variables for the azurerm_windows_virtual_machine module.

variable "windows_vm_name" {
  description = "(Required) Name of the Windows virtual machine."
  type        = string
}

variable "windows_vm_rg_name" {
  description = "(Required) The name of the Azure Resource Group where the Azure Virtual Machine will be created."
  type        = string
}

variable "windows_vm_location" {
  description = "(Required) The location (region) where the Azure Virtual Machine will be created."
  type        = string
}

variable "windows_vm_size" {
  description = "(Required) VM size (e.g., Standard_D2s_v3)."
  type        = string
}

variable "windows_vm_admin_username" {
  description = "(Required) Administrator username."
  type        = string
}

variable "windows_vm_admin_password" {
  description = "(Required) Administrator password."
  type        = string
  sensitive   = true
}

variable "windows_vm_computer_name" {
  description = "(Optional) Computer name for the VM."
  type        = string
}

variable "windows_vm_tags" {
  description = "(Optional) Tags to apply to the virtual machine."
  type        = map(string)
}

variable "windows_vm_os_disk_name" {
  description = "(Optional) The name to use for the OS Disk."
  type        = string
  default     = null
}

variable "windows_vm_os_caching" {
  description = "(Required) OS disk caching type."
  type        = string

  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.windows_vm_os_caching)
    error_message = "caching must be one of: 'None', 'ReadOnly', or 'ReadWrite'."
  }
}

variable "windows_vm_os_storage_account_type" {
  description = "(Required) Storage account type for the OS disk."
  type        = string

  validation {
    condition = contains([
      "Standard_LRS",
      "StandardSSD_LRS",
      "Premium_LRS",
      "StandardSSD_ZRS",
      "Premium_ZRS"
    ], var.windows_vm_os_storage_account_type)

    error_message = "windows_vm_storage_account_type must be one of: Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS, or Premium_ZRS."
  }
}

variable "windows_vm_os_disk_size_gb" {
  description = "(Required) Size of the OS disk in GB."
  type        = number
}

variable "windows_vm_write_accelerator_enabled" {
  description = "(Optional) Enable Write Accelerator. Requires caching = None and storage_account_type = Premium_LRS."
  type        = bool
  default     = false
}

variable "windows_vm_disk_encryption_set_id" {
  description = "(Optional) The ID of the Disk Encryption Set. Conflicts with secure_vm_disk_encryption_set_id."
  type        = string
  default     = null
}

variable "windows_vm_secure_vm_disk_encryption_set_id" {
  description = "(Optional) Disk Encryption Set for Confidential VMs. Cannot be used with disk_encryption_set_id."
  type        = string
  default     = null
}

variable "windows_vm_security_encryption_type" {
  description = "(Optional) Encryption type for Confidential VMs. Required when secure_vm_disk_encryption_set_id is set."
  type        = string
  default     = null

  validation {
    condition     = var.windows_vm_security_encryption_type != null ? contains(["VMGuestStateOnly", "DiskWithVMGuestState"], var.windows_vm_security_encryption_type) : true
    error_message = "Must be null, 'VMGuestStateOnly', or 'DiskWithVMGuestState'."
  }
}

variable "windows_vm_encryption_at_host_enabled" {
  description = "(Optional) Cannot be true if security_encryption_type is DiskWithVMGuestState."
  type        = bool
  default     = false
}

variable "windows_vm_diff_disk_settings" {
  description = "(Optional) Ephemeral disk config. Valid only when caching is 'ReadOnly'."
  type = object({
    option    = string
    placement = optional(string)
  })
  default  = null
  nullable = true
}

variable "windows_vm_publisher" {
  description = "Publisher of the Windows image."
  type        = string
}

variable "windows_vm_offer" {
  description = "Offer for the Windows image."
  type        = string
}

variable "windows_vm_sku" {
  description = "SKU for the Windows image."
  type        = string
}

variable "windows_vm_image_version" {
  description = "Version of the Windows image."
  type        = string
}

variable "windows_vm_identity_type" {
  description = "Managed identity type (SystemAssigned/UserAssigned)."
  type        = string
  default     = null

  validation {
    condition     = var.windows_vm_identity_type != null ? contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.windows_vm_identity_type) : true
    error_message = "The identity type must be either 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'."
  }
}

variable "windows_vm_identity_ids" {
  description = "List of user-assigned identity IDs."
  type        = list(string)
  default     = []
}

variable "windows_vm_availability_zone" {
  description = "Enable availability zone deployment."
  type        = bool
  default     = false
}

variable "windows_vm_vm_zone" {
  description = "Availability zone number."
  type        = number
  default     = 1

  validation {
    condition     = var.windows_vm_vm_zone >= 1 && var.windows_vm_vm_zone <= 3
    error_message = "Availability zone must be 1, 2, or 3"
  }
}

# Optional VM parameters
variable "windows_vm_allow_extension_operations" {
  description = "Indicates if VM extensions are allowed to be installed."
  type        = bool
  default     = true
}

variable "windows_vm_availability_set_id" {
  description = "ID of the availability set to which the VM should belong."
  type        = string
  default     = null
}

variable "windows_vm_bypass_platform_safety_checks_on_user_schedule_enabled" {
  description = "Whether to bypass platform safety checks when scheduling the VM."
  type        = bool
  default     = false
}

variable "windows_vm_capacity_reservation_group_id" {
  description = "ID of the capacity reservation group assigned to this VM."
  type        = string
  default     = null
}

variable "windows_vm_custom_data" {
  description = "Custom data (base64-encoded) passed to the VM."
  type        = string
  default     = null
}

variable "windows_vm_dedicated_host_id" {
  description = "ID of the dedicated host the VM should be assigned to."
  type        = string
  default     = null
}

variable "windows_vm_dedicated_host_group_id" {
  description = "ID of the dedicated host group for the VM."
  type        = string
  default     = null
}

variable "windows_vm_edge_zone" {
  description = "Specifies the Edge Zone within the Azure region."
  type        = string
  default     = null
}

variable "windows_vm_disk_controller_type" {
  description = "Specifies the disk controller type for the VM."
  type        = string
  default     = null

  validation {
    condition     = var.windows_vm_disk_controller_type != null ? contains(["SCSI", "NVMe"], var.windows_vm_disk_controller_type) : true
    error_message = "The disk controller type must be either 'SCSI', 'NVMe', or null."
  }
}

variable "windows_vm_enable_automatic_updates" {
  description = "Specifies whether automatic updates are enabled on the VM."
  type        = bool
  default     = true
}

variable "windows_vm_eviction_policy" {
  description = "Eviction policy for the Spot VM (e.g., Deallocate or Delete)."
  type        = string
  default     = null

  validation {
    condition     = var.windows_vm_eviction_policy != null ? contains(["Deallocate", "Delete"], var.windows_vm_eviction_policy) : true
    error_message = "The eviction policy type must be either 'Deallocate', 'Delete', or null."
  }
}

variable "windows_vm_extensions_time_budget" {
  description = "Maximum time allowed to install VM extensions."
  type        = string
  default     = "PT1H30M"
  nullable    = true

}

variable "windows_vm_hotpatching_enabled" {
  description = "Enable hotpatching for the VM if supported."
  type        = bool
  default     = false
}

variable "windows_vm_license_type" {
  description = "Specifies the license type (e.g., Windows_Server)."
  type        = string
  default     = null

  validation {
    condition     = var.windows_vm_license_type != null ? contains(["None", "Windows_Client", "Windows_Server"], var.windows_vm_license_type) : true
    error_message = "The license type must be either 'None', 'Windows_Client', 'Windows_Server' or null."
  }
}

variable "windows_vm_max_bid_price" {
  description = "Maximum price one is willing to pay per hour for a Spot VM."
  type        = number
  default     = -1
}

variable "windows_vm_patch_assessment_mode" {
  description = "Defines how patch assessment should be performed."
  type        = string
  default     = "ImageDefault"

  validation {
    condition     = contains(["AutomaticByPlatform", "ImageDefault"], var.windows_vm_patch_assessment_mode)
    error_message = "The patch assessment type must be either 'AutomaticByPlatform' or 'ImageDefault'."
  }
}

variable "windows_vm_patch_mode" {
  description = "Specifies the patching mode (e.g., AutomaticByOS)."
  type        = string
  default     = "AutomaticByOS"

  validation {
    condition     = contains(["Manual", "AutomaticByOS", "AutomaticByPlatform"], var.windows_vm_patch_mode)
    error_message = "The patch mode must be either 'Manual', 'AutomaticByOS' or 'AutomaticByPlatform'."
  }
}

variable "windows_vm_platform_fault_domain" {
  description = "Specifies the fault domain the VM should be placed in."
  type        = number
  default     = null
  nullable    = true
}

variable "windows_vm_priority" {
  description = "Specifies the VM priority (Regular or Spot)."
  type        = string
  default     = "Regular"

  validation {
    condition     = contains(["Spot", "Regular"], var.windows_vm_priority)
    error_message = "The priority must be either 'Spot' or 'Regular'."
  }
}

variable "windows_vm_provision_vm_agent" {
  description = "Indicates if the Azure VM agent should be provisioned on the VM."
  type        = bool
  default     = true
}

variable "windows_vm_proximity_placement_group_id" {
  description = "ID of the proximity placement group the VM should be part of."
  type        = string
  default     = null
}

variable "windows_vm_reboot_setting" {
  description = "Specifies the reboot setting for VM maintenance operations."
  type        = string
  default     = null

  validation {
    condition     = var.windows_vm_reboot_setting != null ? contains(["Always", "IfRequired", "Never"], var.windows_vm_reboot_setting) : true
    error_message = "The reboot setting must be either 'Always', 'IfRequired' or 'Never'."
  }
}

variable "windows_vm_secure_boot_enabled" {
  description = "Enable secure boot on the virtual machine."
  type        = bool
  default     = null
}

variable "windows_vm_timezone" {
  description = "Timezone to set for the Windows VM."
  type        = string
  default     = null
}

variable "windows_vm_user_data" {
  description = "Base64-encoded user data to provide when launching the instance."
  type        = string
  default     = null
}

variable "windows_vm_virtual_machine_scale_set_id" {
  description = "ID of the virtual machine scale set the VM should be associated with."
  type        = string
  default     = null
}

variable "windows_vm_vtpm_enabled" {
  description = "(Optional) Must be true if security_encryption_type is set."
  type        = bool
  default     = false
}

# Dynamic blocks
variable "windows_vm_additional_capabilities" {
  description = "(Optional) Additional capabilities to enable Ultra SSD and/or hibernation support."
  type = object({
    ultra_ssd_enabled   = optional(bool) //Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
    hibernation_enabled = optional(bool) //(Optional) Whether to enable the hibernation capability or not.
  })
  default  = null
  nullable = true
}

variable "windows_vm_additional_unattend_content" {
  description = "(Optional) Additional unattend content to specify custom Windows setup configuration settings."
  type = object({
    content = optional(string) //(Required) The XML formatted content that is added to the unattend.xml file for the specified path and component. Changing this forces a new resource to be created.
    setting = optional(string) //(Required) The name of the setting to which the content applies. Possible values are AutoLogon and FirstLogonCommands.
  })
  default  = null
  nullable = true
}

variable "windows_vm_boot_diagnostics" {
  description = "Configuration block for enabling boot diagnostics on the VM. Set 'storage_account_uri' to specify the storage account URI where boot logs and screenshots will be stored.Passing null uses a Managed Storage Account."
  type = object({
    storage_account_uri = optional(string) //(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor.
  })
  default  = null
  nullable = true
}

variable "windows_vm_gallery_application" {
  description = "Defines configuration for Windows VM gallery application."
  type = object({
    version_id                                  = optional(string)      //(Required) Specifies the Gallery Application Version resource ID.
    automatic_upgrade_enabled                   = optional(bool, false) //(Optional) Specifies whether the version will be automatically updated for the VM when a new Gallery Application version is available in PIR/SIG. Defaults to false.
    configuration_blob_uri                      = optional(string)      //(Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
    order                                       = optional(number, 0)   //(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2147483647. Defaults to 0.
    gallerytag                                  = optional(string)      //(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
    treat_failure_as_deployment_failure_enabled = optional(bool, false) //(Optional) Specifies whether any failure for any operation in the VmApplication will fail the deployment of the VM. Defaults to false.
  })
  default  = null
  nullable = true
}

variable "windows_vm_plan" {
  description = "Defines the Marketplace image plan details required when deploying a VM from a Marketplace image."
  type = object({
    planame   = optional(string) //(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. 
    product   = optional(string) //(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from.
    publisher = optional(string) //(Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from.
  })
  default  = null
  nullable = true
}

variable "windows_vm_secret" {
  description = "Specifies the Key Vault secret and certificate settings to inject certificates into the VM."
  type = object({
    key_vault_id = optional(string) //(Required) The ID of the Key Vault from which all Secrets should be sourced.
    certificate = optional(object({
      store = optional(string) //(Required) The certificate store on the Virtual Machine where the certificate should be added.
      url   = optional(string) //(Required) The Secret URL of a Key Vault Certificate.
    }))
  })
  default  = null
  nullable = true
}

variable "windows_vm_os_image_notification" {
  description = "Defines an optional OS image upgrade notification with a timeout for Windows VM instance metadata."
  type = object({
    timeout = optional(string) //(Optional) Length of time a notification to be sent to the VM on the instance metadata server till the VM gets OS upgraded. The only possible value is PT15M. Defaults to PT15M.
  })
  default  = null
  nullable = true
}

variable "windows_vm_termination_notification" {
  description = "Configuration for VM termination notification."
  type = object({
    enabled = optional(bool)   //(Required) Should the termination notification be enabled on this Virtual Machine
    timeout = optional(string) //(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format. Defaults to PT5M.
  })
  default  = null
  nullable = true
  validation {
    condition     = var.windows_vm_termination_notification != null ? (var.windows_vm_termination_notification.timeout != null ? contains(["PT5M", "PT6M", "PT7M", "PT8M", "PT9M", "PT10M", "PT11M", "PT12M", "PT13M", "PT14M", "PT15M"], var.windows_vm_termination_notification.timeout) : true) : true
    error_message = "Timeout must be null or one of: PT5M (5min) to PT15M (15min) (ISO 8601 duration)."
  }
}

variable "windows_vm_winrm_listener" {
  description = "Configuration for the WinRM listener."
  type = object({
    protocol        = optional(string) //(Required) Specifies the protocol of listener. Possible values are Http or Https.
    certificate_url = optional(string) //(Optional) The Secret URL of a Key Vault Certificate, which must be specified when protocol is set to Https.
  })
  default  = null
  nullable = true
}
