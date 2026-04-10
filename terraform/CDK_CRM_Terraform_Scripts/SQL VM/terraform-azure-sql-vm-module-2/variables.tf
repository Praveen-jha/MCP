variable "subscription_id" {
  type        = string
  description = "The subscription ID to use for the VM"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual machine and related resources are located."
}

variable "prefix" {
  type        = string
  description = "Naming prefix to use"
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Location of the resource group."
}

variable "name" {
  type        = string
  description = "Name of the resource to be created"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The allocation method for the private IP address. Options include 'Dynamic' or 'Static'."
  default     = "Dynamic"
}

variable "timezone_id" {
  type        = string
  default     = "Central Standard Time"
  description = "Timezone ID for the vm"
}

variable "size" {
  type        = string
  description = "The size of the virtual machine, which defines its compute resources (e.g., 'Standard_F2')."
}

variable "caching" {
  type        = string
  description = "The caching type for the virtual machine's OS disk (e.g., 'ReadWrite', 'ReadOnly')."
  default     = "ReadWrite"
}

variable "storage_account_type" {
  type        = string
  description = "The type of storage account for the OS disk (e.g., 'Standard_LRS', 'Premium_LRS')."
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  type        = number
  description = "The Size of the Internal OS Disk in GB."
  default     = 128
}

variable "subnet_id" {
  type        = string
  description = "The resource ID of the subnet where the virtual machine will be deployed."
}

variable "vm_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Virtual Network."
  default     = {}
}

variable "nic_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Virtual Network."
  default     = {}
}

variable "availability_zone" {
  type        = bool
  description = "Variable to determine if we want to deploy Virtual Machine in Availability Zone or not."
  default     = false
}

variable "vm_zone" {
  type        = string
  description = "Specifies the Availability Zone in which this Windows Virtual Machine should be located."
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the SQL Managed Instance"

  validation {
    condition = alltrue([
      contains(keys(var.tags), "cdk_asset_id"),
      contains(keys(var.tags), "cdk_asset_name"),
      contains(keys(var.tags), "cdk_portfolio"),
      contains(keys(var.tags), "cdk_sub_portfolio"),
      contains(keys(var.tags), "cdk_provisioner"),
      contains(keys(var.tags), "cdk_environment"),
      contains(keys(var.tags), "cdk_app_criticality"),
      contains(keys(var.tags), "cdk_account_type"),
      contains(keys(var.tags), "cdk_cluster_type")
    ])
    error_message = "The variable \"tags\" must contain *all* of the following: \"cdk_asset_id\", \"cdk_asset_name\", \"cdk_portfolio\", \"cdk_sub_portfolio\", \"cdk_provisioner\", \"cdk_environment\", \"cdk_app_criticality\", \"cdk_account_type\", \"cdk_cluster_type\""
  }
}

variable "gallery_name" {
  description = "The source gallery name where the VM images are published"
  type        = string
  default     = "cdk_published_images"
}

variable "gallery_resource_group_name" {
  description = "The gallery resource group name where the images are published"
  type        = string
  default     = "rg-ghs-image-gallery-cus-01"
}

variable "image_version" {
  description = "The image version."
  type        = string
  default     = "2025.0701.101"
}

variable "image_name" {
  description = "The image name"
  type        = string
  # default = "CDK_Win2025"
}

variable "disk_sku" {
  type    = string
  default = "Standard_LRS"
}

variable "disk_controller_type" {
  type        = string
  description = "(Optional) Specifies the Disk Controller Type used for this Virtual Machine. Possible values are SCSI and NVMe."
  default     = "SCSI"
}

variable "db_log_path" {
  type    = string
  default = "L:\\Logs"
}

variable "db_log_size_gb" {
  type = number
}

variable "db_log_number_of_disks" {
  type        = number
  description = "Number of log disks to create."
}

variable "db_log_iops" {
  type        = number
  description = "Total IOPS for all log disks. Defaults to null if not specified."
  default     = null
}

variable "db_log_throughput" {
  type        = number
  description = "Total throughput for all log disks. Defaults to null if not specified."
  default     = null
}

variable "db_log_disk_type" {
  type        = string
  description = "Storage account type for log disks (e.g., 'Premium_LRS', 'Standard_LRS')."
  default     = "PremiumV2_LRS"
}

variable "db_log_disk_caching" {
  type        = string
  description = "Caching type for data disks (e.g., 'ReadWrite', 'None')."
  default     = "None"
}

variable "db_data_path" {
  type    = string
  default = "M:\\Data"
}

variable "db_data_size_gb" {
  type = number
}

variable "db_data_number_of_disks" {
  type        = number
  description = "Number of data disks to create."
}

variable "db_data_iops" {
  type        = number
  description = "Total IOPS for all data disks. Defaults to null if not specified."
  default     = null
}

variable "db_data_throughput" {
  type        = number
  description = "Total throughput for all data disks. Defaults to null if not specified."
  default     = null
}

variable "db_data_disk_type" {
  type        = string
  description = "Storage account type for data disks (e.g., 'Premium_LRS', 'Standard_LRS')."
  default     = "PremiumV2_LRS"
}

variable "db_data_disk_caching" {
  type        = string
  description = "Caching type for data disks (e.g., 'ReadWrite', 'None')."
  default     = "None"
}

variable "db_tempdb_path" {
  type    = string
  default = "T:\\tempdb"
}

variable "db_tempdb_size_gb" {
  type = number
}

variable "collation" {
  type        = string
  default     = "Latin1_General_CI_AI" # "SQL_Latin1_General_CP1_CI_AI"
  description = "Collation for the SQL Managed Instance"
}

variable "sql_license_type" {
  type        = string
  description = "The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created."
  default     = "AHUB"
}

variable "sql_sysadmin_group_name" {
  type        = string
  nullable    = true
  default     = null
  description = "The name of the Entra group to grant sysadmin server role on SQL Server for DBA admin access"
}
