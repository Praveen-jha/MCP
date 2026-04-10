// variables.tf
// This file defines the input variables for the azurerm_managed_disk module.

variable "data_disk_name" {
  description = "(Required) The name of the managed data disk."
  type        = string
}

variable "data_disk_location" {
  description = "(Required) The Azure region where the disk will be created."
  type        = string
}

variable "data_disk_rg_name" {
  description = "(Required) The name of the resource group where the disk will be present."
  type        = string
}

variable "data_disk_storage_account_type" {
  description = "(Required) The type of storage account (e.g., Standard_LRS, Premium_LRS)."

  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_ZRS", "Premium_LRS", "PremiumV2_LRS", "Premium_ZRS", "StandardSSD_LRS", "UltraSSD_LRS"], var.data_disk_storage_account_type)
    error_message = "Storage Account Type can be either 'Standard_LRS', 'StandardSSD_ZRS', 'Premium_LRS', 'PremiumV2_LRS', 'Premium_ZRS', 'StandardSSD_LRS', or 'UltraSSD_LRS'."
  }
}

variable "data_disk_create_option" {
  description = "(Required) Specifies how the managed disk is created (e.g., Empty, Copy, FromImage)."
  type        = string

  validation {
    condition     = contains(["Import", "ImportSecure", "Empty", "Copy", "FromImage", "Restore", "Upload"], var.data_disk_create_option)
    error_message = "Data Disk Create Option can be either 'Import', 'ImportSecure', 'Empty', 'Copy', 'FromImage', 'Restore', or 'Upload'."
  }
}

variable "data_disk_tags" {
  description = "(Optional) A map of tags to assign to the disk."
  type        = map(string)
}

# Optional Variables
variable "data_disk_size_gb" {
  description = "The size of the disk in gigabytes."
  type        = number
}

variable "data_disk_zone" {
  description = "The availability zone for the managed disk."
  type        = string
  default     = null
}

variable "data_disk_os_type" {
  description = "The operating system type (e.g., Windows, Linux)."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.data_disk_os_type != null ? contains(["Linux", "Windows"], var.data_disk_os_type) : true
    error_message = "Data Disk OS Type can be either 'Linux', 'Windows', or 'null'."
  }
}

variable "data_disk_disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set to use."
  type        = string
  default     = null
}

variable "data_disk_secure_vm_disk_encryption_set_id" {
  description = "The ID of the Secure VM Disk Encryption Set to use."
  type        = string
  default     = null
}

variable "data_disk_iops_read_write" {
  description = "Maximum IOPS for read/write operations."
  type        = number
  default     = null
}

variable "data_disk_mbps_read_write" {
  description = "Maximum throughput in MBps for read/write operations."
  type        = number
  default     = null
}

variable "data_disk_iops_read_only" {
  description = "Maximum IOPS for read-only operations."
  type        = number
  default     = null
}

variable "data_disk_mbps_read_only" {
  description = "Maximum throughput in MBps for read-only operations."
  type        = number
  default     = null
}

variable "data_disk_upload_size_bytes" {
  description = "Maximum upload size in bytes."
  type        = number
  default     = null
}

variable "data_disk_edge_zone" {
  description = "The edge zone of the managed disk."
  type        = string
  default     = null
}

variable "data_disk_hyper_v_generation" {
  description = "The Hyper-V generation of the virtual machine."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.data_disk_hyper_v_generation != null ? contains(["V1", "V2"], var.data_disk_hyper_v_generation) : true
    error_message = "Data Disk Hyper V Generation can be either 'V1', or 'V2'."
  }
}

variable "data_disk_image_reference_id" {
  description = "The ID of the image to be used for the disk."
  type        = string
  default     = null
}

variable "data_disk_gallery_image_reference_id" {
  description = "The ID of the gallery image to be used."
  type        = string
  default     = null
}

variable "data_disk_logical_sector_size" {
  description = "The logical sector size of the disk."
  type        = number
  default     = null
  nullable    = true

  validation {
    condition     = var.data_disk_logical_sector_size != null ? contains([512, 4096], var.data_disk_logical_sector_size) : true
    error_message = "Logical Sector Size can be either 512 or 4096."
  }
}

variable "data_disk_optimized_frequent_attach_enabled" {
  description = "Indicates whether optimized frequent attach is enabled."
  type        = bool
  default     = false
}

variable "data_disk_performance_plus_enabled" {
  description = "Indicates whether performance plus is enabled."
  type        = bool
  default     = false
}

variable "data_disk_source_resource_id" {
  description = "The source resource ID for the managed disk."
  type        = string
  default     = null
}

variable "data_disk_source_uri" {
  description = "The source URI for the managed disk."
  type        = string
  default     = null
}

variable "data_disk_storage_account_id" {
  description = "The storage account ID associated with the disk."
  type        = string
  default     = null
}

variable "data_disk_tier" {
  description = "The performance tier of the managed disk."
  type        = string
  default     = null
}

variable "data_disk_max_shares" {
  description = "The maximum number of shares allowed for a disk."
  type        = number
  default     = null
}

variable "data_disk_trusted_launch_enabled" {
  description = "Indicates if trusted launch is enabled."
  type        = bool
  default     = null
  nullable    = true
}

variable "data_disk_security_type" {
  description = "The security type of the disk."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.data_disk_security_type != null ? contains(["ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey", "ConfidentialVM_DiskEncryptedWithPlatformKey", "ConfidentialVM_DiskEncryptedWithCustomerKey"], var.data_disk_security_type) : true
    error_message = "Data Disk Security Type can be either 'ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey', 'ConfidentialVM_DiskEncryptedWithPlatformKey', or 'ConfidentialVM_DiskEncryptedWithCustomerKey'."
  }
}

variable "data_disk_on_demand_bursting_enabled" {
  description = "Indicates if on-demand bursting is enabled."
  type        = bool
  default     = null
  nullable    = true
}

variable "data_disk_network_access_policy" {
  description = "The network access policy for the disk."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.data_disk_network_access_policy != null ? contains(["AllowAll", "AllowPrivate", "DenyAll"], var.data_disk_network_access_policy) : true
    error_message = "Data Disk Network Access Policy can be either 'AllowAll', 'AllowPrivate', or 'DenyAll'."
  }
}

variable "data_disk_access_id" {
  description = "The disk access resource ID."
  type        = string
  default     = null
}

variable "data_disk_public_network_access_enabled" {
  description = "Indicates whether public network access is enabled."
  type        = bool
  default     = false
}


variable "data_disk_encryption_settings" {
  description = "Defines the Encryption Settings"
  type = object({
    disk_encryption_key = optional(object({
      secret_url      = optional(string)
      source_vault_id = optional(string)
    }))
    key_encryption_key = optional(object({
      key_url         = optional(string)
      source_vault_id = optional(string)
    }))
  })
  nullable = true
  default  = null
}
