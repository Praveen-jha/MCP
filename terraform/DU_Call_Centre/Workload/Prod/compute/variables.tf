# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
}

# Variable for the Business unit name
variable "bu_name" {
  type        = string
  description = "The name of the Business unit."
}

# The geographical location where the resources will be deployed.
variable "location" {
  type        = string
  description = "Location of the resources."
}

# Variable to define tags
variable "tags" {
  type        = map(string)
  description = "A map of common tags to assign resources."
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
    identity_type                      = string
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
