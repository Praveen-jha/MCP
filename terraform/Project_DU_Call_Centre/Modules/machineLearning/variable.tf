# Specifies the Azure region where the resource group will be created
variable "location" {
  description = "The location of the resource group"
  type        = string
}

# The name of the resource group in which resources will be created
variable "resource_group_name" {
  type = string
}

# The ID of the Storage Account to be used
variable "storage_account_id" {
  description = "The name of the Storage Account"
  type        = string
}

# The ID of the Application Insights instance for monitoring
variable "application_insights_id" {
  description = "The name of the Application Insights instance"
  type        = string
}

# The name of the Azure Machine Learning workspace
variable "ml_workspace_name" {
  description = "The name of the Machine Learning workspace"
  type        = string
}

# The type of identity assigned to the Machine Learning workspace (e.g., SystemAssigned, UserAssigned)
variable "ml_workspace_identity_type" {
  type = string
}

# The list of IDs for user-assigned identities associated with the Machine Learning workspace
variable "ml_workspace_identity_id" {
  type = list(string)
}

# The ID of the Azure Key Vault to be used for storing secrets
variable "key_vault_id" {
  type = string
}

# Boolean flag to enable or disable public network access for the Machine Learning workspace
variable "public_network_access_enabled_ml" {
  description = "Enable public access when this Machine Learning Workspace is behind VNet"
  type        = bool
}

# A map of tags to assign to the resources
variable "tags" {
  type = map(string)
}

# Specifies the network isolation mode for the Machine Learning workspace
variable "isolation_mode_ml" {
  description = "(Optional) The isolation mode of the Machine Learning Workspace. Possible values are Disabled, AllowOnlyApprovedOutbound, and AllowInternetOutbound"
  type        = string
}

# The ID of the user-assigned identity to be used
variable "user_assigned_identity_id" {
  type = string
}
