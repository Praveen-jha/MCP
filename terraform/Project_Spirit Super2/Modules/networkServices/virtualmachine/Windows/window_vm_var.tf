
variable "location" {
  type = string
  description = "The location (region) where the Virtual Machine will be created."
}

variable "rgName" {
  type = string
  description = "The name of the Azure Resource Group where the Virtual Machine will be created."
}

variable "Tag" {
  type = map(string)
  description = "A map of tags to assign to the Virtual Machine."
}

variable "subnet_id" {
  type = string
  description = "Subnet Resource ID."
}

variable "vmName" {
  type = string
  description = "Name of the Virtual Machines to be created."
}

variable "nicName" {
  type = string
  description = "Name of the Netowrk Interface Card "
}

# variable "publicIpName" {
#   type = string
#   description = "Name of the Public IP to be created for Virtual Machine"
# }

# variable "computerName" {
#   type = string
#   description = "Specifies the Hostname which should be used for this Virtual Machine."
# }

variable "adminUsername" {
  type = string
  description = "Value of the Admin User Name for the Virtual Machine."
}

variable "adminPassword" {
  type = string
  description = "Value of the Password for the Virtual Machine."
}

variable "osdiskName" {
  type = string
  description = "Name of the Virtual Machine OS Disk."
}

variable "vmConfig" {
  type = object({
    vmSize                            = string
    caching                           = string
    storageAccountType                = string
    publisher                         = string
    offer                             = string
    sku                               = string
    version                           = string
    NIC_ip_configuration              = string
    NIC_private_ip_address_allocation = string
    //Public_IP_Allocation_Method       = string
  })
  description = "Virtual Machine Configurations."
}
