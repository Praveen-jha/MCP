variable "virtual_machine_id" {
  type = string
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
  type = string
  description = "The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created."
}