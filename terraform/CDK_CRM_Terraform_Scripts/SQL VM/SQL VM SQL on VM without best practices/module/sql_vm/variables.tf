variable "virtual_machine_id" {
  type        = string
  description = "Virtual Machine Resource ID."
}

variable "sqlConnectivityType" {
  type        = string
  description = "The SQL connectivity type (e.g., 'Private', 'Public')."
}

variable "sqlPortNumber" {
  type        = number
  description = "The port number for SQL connectivity."
}

variable "sqlAuthenticationLogin" {
  type        = string
  description = "The SQL Authentication login username."
}

variable "sqlAuthenticationPassword" {
  type        = string
  description = "The SQL Authentication login password."
  sensitive   = true
}

variable "sql_license_type" {
  type        = string
  description = "The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created."
}

variable "storage_configuration" {
  type        = any
  nullable    = true
  default     = {}
  description = "Variable for Storage Configuration Values,The type of disk configuration to apply to the SQL Server, The type of storage workload, Specifies whether to set system databases (except tempDb) location to newly created data storage, The SQL Server default path, A list of Logical Unit Numbers for the disks, The SQL Server default file count, The SQL Server default file size,  "
}

variable "sql_instance" {
  type        = any
  nullable    = true
  default     = {}
  description = "Variable for SQL Instance Values, Colation, max dop, minimum server memory, maximum server memory, lock pages in memory enable, indstant file initializatin enabled and adhoc workload optimization enabled."
}

variable "key_vault_credential" {
  type        = any
  nullable    = true
  default     = {}
  description = "Key Vault Credential for Key Vault Credential Name, Key Vault URL, Service Principal Name and Service Principal Secret"
}

variable "auto_patching" {
  type        = any
  nullable    = true
  default     = {}
  description = "Auto Patching for the day of week to apply the patch on, The Hour in the Virtual Machine Time-Zone when the patching maintenance window should begin and The size of the Maintenance Window in minutes."
}

variable "auto_backup" {
  type        = any
  nullable    = true
  default     = {}
  description = "Auto backup for encryption password,manual schedule,retention period, storage blob endpoin, storage account access key and system databases backup enabled or not."
}