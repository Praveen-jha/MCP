variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual machine and related resources are located."
}

variable "location" {
  type        = string
  description = "The Azure region where the virtual machine and related resources will be deployed."
}

variable "storage_account_name" {
  type        = string
  description = "Name of storage account"
}

variable "storage_account_tier" {
  type        = string
  description = "storage account tier"
}

variable "storage_account_replication_type" {
  type        = string
  description = "storage account replication type"
}

variable "failover_cluster_name" {
  description = "The Windows Failover Cluster Name. Maximum length is 15."
  type        = string
  validation {
    condition     = length(var.failover_cluster_name) <= 15
    error_message = "The failover_cluster_name must be a maximum of 15 characters."
  }
}

variable "sql_server_image_type" {
  description = "The SQL Server Image type (e.g., 'SQL2022-WS2022')."
  type        = string
}

variable "sql_server_sku" {
  description = "The SQL Server Gallery Image SKU (e.g., 'Enterprise', 'Standard')."
  type        = string
}

variable "domain_user_name" {
  description = "The domain user account used to create FCI name in Active Directory and join VMs to Domain."
  type        = string
}

variable "domain_fqdn" {
  description = "The Domain FQDN where the virtual machine will be joined."
  type        = string
}

variable "domain_user_password" {
  description = "The password for the domain user account."
  type        = string
  sensitive   = true
}

variable "vm_names" {
  description = "A list of VM names for replicas."
  type        = list(string)
}

variable "sql_license_type" {
  type = string
  description = "The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created."
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

variable "availability_group" {
  description = "The name of the SQL Availability Group."
  type        = string
}

variable "cluster_subnet_type" {
  type = string
  description = "Cluster Subnet Type"
}

variable "replica_role_array" {
  description = "Replica role setting for each AG replica (e.g., 'Primary', 'Secondary')."
  type        = list(string)
}

variable "replica_auto_fail_array" {
  description = "Replica auto failover setting for each AG replica (e.g., 'Automatic', 'Manual')."
  type        = list(string)
}

variable "replica_sync_commit_array" {
  description = "Replica sync commit setting for each AG replica (e.g., 'Synchronous', 'Asynchronous')."
  type        = list(string)
}

variable "replica_readable_sec_array" {
  description = "Replica readable secondary setting for each AG replica (e.g., 'No', 'Yes')."
  type        = list(string)
}

variable "list_of_listener_ips" {
  description = "A list of IP addresses for the AG Listener, one for each subnet."
  type        = list(string)
}

variable "listener_name" {
  description = "The name for the AG Listener. Maximum length is 15."
  type        = string
  validation {
    condition     = length(var.listener_name) <= 15
    error_message = "The listener_name must be a maximum of 15 characters."
  }
}

variable "existing_virtual_network_name" {
  description = "The name of the existing virtual network."
  type        = string
}

variable "subnet_names" {
  description = "A list of subnet names, one for each VM replica."
  type        = list(string)
}