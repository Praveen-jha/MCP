// variables.tf
// This file defines the input variables for the azurerm_virtual_machine_data_disk_attachment module.

variable "virtual_machine_id" {
  description = "(Required) The ID of the Virtual Machine to attach the data disk to."
  type        = string
}

variable "managed_disk_id" {
  description = "(Required) The ID of the managed disk to attach."
  type        = string
}

variable "virtual_machine_data_disk_lun" {
  description = "(Required) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine."
  type        = number
}

variable "virtual_machine_data_disk_caching" {
  description = "(Required) Specifies the caching type for the data disk. Possible values: None, ReadOnly, ReadWrite."
  type        = string

  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.virtual_machine_data_disk_caching)
    error_message = "caching must be one of: 'None', 'ReadOnly', or 'ReadWrite'."
  }
}

variable "virtual_machine_data_disk_create_option" {
  description = "(Optional) The method used when attaching the disk."
  type        = string
  default     = "Attach"

  validation {
    condition     = contains(["Empty", "Attach"], var.virtual_machine_data_disk_create_option)
    error_message = "create option must be either 'Empty', or 'Attach'."
  }
}

variable "write_accelerator_enabled" {
  description = "(Optional) Specifies whether write accelerator is enabled on the data disk."
  type        = bool
  default     = false
}
