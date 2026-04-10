variable "sql_managed_instance_identity_principal_id" {
  type        = string
  description = "The object (principal) ID of the system-assigned managed identity for the Azure SQL Managed Instance. This ID is used to assign Entra ID roles to the managed identity."
}

variable "display_name" {
  type        = string
  description = "The display name of the Entra ID (Azure AD) directory role to be assigned to the managed identity. For example: 'Directory Readers'."
}
