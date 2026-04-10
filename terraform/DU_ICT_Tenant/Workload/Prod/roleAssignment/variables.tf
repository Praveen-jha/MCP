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
