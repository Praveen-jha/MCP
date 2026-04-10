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

variable "data_disks_name" {
  type = list(string)
  description = "Names for Data Disks."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual machine and related resources are located."
}
 
variable "location" {
  type        = string
  description = "The Azure region where the virtual machine and related resources will be deployed."
}

variable "vm_id" {
  type        = string
  description = "virtual machine id to which data disk will be attached"
}