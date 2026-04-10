# Variable for the name of the Azure Key Vault
# This specifies the unique name of the Key Vault resource in Azure.
variable "key_vault_name" {
  type        = string
  description = "The name of the Azure Key Vault."
}

# Variable for the resource group name where the Key Vault is located
# This defines the name of the resource group in which the Key Vault resides.
variable "key_vault_resource_group_name" {
  type        = string
  description = "The name of the resource group containing the Azure Key Vault."
}

# User-managed identity ID used for authentication and role assignments.
variable "umi_id_name" {
  type        = string
  description = "User managed identity id"
}

# Name of the storage account where data will be stored.
variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
}

# Name of the resource group that contains the app service.
variable "app_service_resource_group_name" {
  type        = string
  description = "Name of the app service resource group"
}

# Name of the Node.js app service.
variable "node_app_service_name" {
  type        = string
  description = "The name of the node app service."
}

# Name of the Python app service.
variable "python_app_service_name" {
  type        = string
  description = "The name of the python app service."
}

# Name of the storage account used for storing Terraform state files.
variable "tfstate_stoarge_name" {
  type        = string
  description = "The name of the tfstate storage account"
}

# Name of the resource group containing the Terraform state storage account.
variable "tfstate_stoarge_resource_group_name" {
  type        = string
  description = "The name of the tfstate storage account"
}






