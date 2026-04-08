variable "adb_connector_name" {
  description = "The name of the Databricks Access Connector."
  type        = string
}

variable "adb_connector_rg" {
  description = "The name of the resource group where the Databricks Access Connector will be deployed."
  type        = string
}

variable "adb_connector_location" {
  description = "The location where the Databricks Access Connector will be deployed."
  type        = string
}

variable "tags" {
  description = "A map of tags to associate with the Databricks Access Connector."
  type        = map(string)
}

variable "identity_type" {
  description = "The type of identity to assign to the Databricks Access Connector (e.g., 'SystemAssigned')."
  type        = string
}
