# REQUIRED VARIABLES (variables which are needed to be passed)
variable "rg_name" {
  description = "The name of the Azure resource group where the AI Services will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the AI Services will be deployed"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the Microsoft SQL Server"
  type        = string
}

variable "sql_server_version" {
  description = "The version for the new server"
  type        = string
}

# OPTIONAL VARIABLES (variables which are not necessary to be passed)
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "sql_server_admin_login" {
  description = "The administrator login name for the new server"
  type        = string
}

variable "sql_server_admin_password" {
  description = "The password associated with the administrator login user"
  type        = string
}

variable "sql_server_min_tls_version" {
  description = "The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server"
  type        = string
}

variable "sql_server_identity" {
  description = "Type of Managed Service Identity that should be configured on the SQL Server"
  type = object({
    type         = string
    identity_ids = list(string)
  })
}

variable "sql_server_azure_ad_administrator" {
  description = "SQL server authenticaiton through Azure AD"
  type        = map(string)
}

variable "sql_public_network_access_enabled" {
  description = "Boolean flag to enable or disable public network access for the Azure SQL Database."
  type        = bool
  default     = false
}

variable "sql_databases" {
  description = "Map of SQL database names and their configurations"
  type = map(object({
    database_name              = string
    license_type               = string
    max_size_gb                = number
    sku_name                   = string
    enclave_type               = string
    ledger_enabled             = bool
    zone_redundant             = bool
    secondary_type             = string
    long_term_weekly_retention = string
  }))
}

variable "key_vault_key_id" {
  type        = string
  description = "Key Vault Key Id for CMK"
}

variable "key_scope_id" {
  type        = string
  description = "Versionless Key Vault Key Id"
}

variable "auditing_policy_enabled" {
  description = "Is extended auditing policy enabled for SQL server"
  type        = bool
  default     = true
}

variable "storage_account_primary_access_key" {
  description = "storage account primary access key for extended auditing"
  type        = string
  default     = ""
}

variable "storage_account_primary_blob_endpoint" {
  description = "storage account primary blob endpoint for extended auditing"
  type        = string
  default     = ""
}

variable "storage_account_id" {
  description = "storage account id for role assignment"
  type        = string
  default     = ""
}
