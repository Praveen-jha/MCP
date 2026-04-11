# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
}

# Variable for the subscription
variable "subscription_id" {
  type        = string
  description = "The name of the subscription_id"
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}


# The geographical location where the resources will be deployed.
variable "location" {
  type        = string
  description = "Location of the resources."
}


# The name of the subnet to retrieve information for.
variable "compute_subnet_name" {
  type        = string
  description = "The name of the subnet."
}

# The name of the virtual network containing the subnet.
variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network containing the subnet."
}

# The name of the resource group where the virtual network and subnet reside.
variable "subnet_resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual network and subnet are located."
}

variable "windows_vm_configs" {
  description = "Map of VM configurations"
  type = map(object({
    size                               = string
    windows_sku                        = string
    windows_offer                      = string
    windows_publisher                  = string
    admin_username                     = string
    password                           = string
    computer_name                      = string
    vm_tags                            = map(string)
    nic_tags                           = map(string)
    caching                            = string
    storage_account_type               = string
    image_version                      = string
    IP_allocation_method               = string
    private_ip_address_allocation      = string
    nic_accelerated_networking_enabled = bool
    auto_shutdown_enable               = bool
    vm_identity_type                   = string
    instance_number                    = string
    vm_workload_type                   = string
  }))
}

variable "shutdown_timezone" {
  description = "Timezone for auto shutdown"
  type        = string
}

variable "shutdown_notification_enabled" {
  description = "Enable notification for auto shutdown"
  type        = bool
}

variable "daily_recurrence_time" {
  description = "Specify the VM shutdown time"
  type        = string
}

variable "auto_shutdown_notification_email" {
  description = "provide the email ID to send the VM shutdown notification"
  type        = string
}

# variable "key_vault_rg_name" {
#   description = "key Vault RG name"
#   type        = string
# }

# variable "key_vault_name" {
#   description = "key Vault name"
#   type        = string
# }
variable "resource_group_tags" {
  description = "resource group tags"
  type        = map(string)
}

variable "rg_creation" {
  description = "Resource Creation"
  type        = string
}

variable "rg_location" {
  description = "RG Location"
  type        = string
}
variable "location_shortname" {
  description = "Location shortname"
  type        = string
}
variable "workload_type" {
  description = "workload type of the resource"
  type        = string
}

variable "linux_vm_configs" {
  description = "Map of VM configurations"
  type = map(object({
    size                               = string
    linux_sku                          = string
    linux_offer                        = string
    linux_publisher                    = string
    admin_username                     = string
    computer_name                      = string
    vm_tags                            = map(string)
    nic_tags                           = map(string)
    caching                            = string
    storage_account_type               = string
    disk_size_gb                       = number
    disable_password_authentication    = bool
    image_version                      = string
    IP_allocation_method               = string
    private_ip_address_allocation      = string
    nic_accelerated_networking_enabled = bool
    auto_shutdown_enable               = bool
    vm_identity_type                   = string
    instance_number                    = string
    vm_workload_type                   = string
  }))
}

variable "dataDiskResources" {
  type = list(object({
    sku  = string
    properties = object({
      createOption = string
      diskSizeGB   = number
    })
  }))
  description = "A list of managed disk resources to be created separately."
}