data "azurerm_subnet" "compute_subnet" {
  name                 = var.compute_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.subnet_resource_group_name
}

# data "azurerm_key_vault" "key_vault" {
#   resource_group_name = var.key_vault_rg_name
#   name                = var.key_vault_name
# }

# data "azurerm_user_assigned_identity" "uaid" {
#   resource_group_name = var.key_vault_rg_name
#   name                = var.uaid_name
# }

# # Name of the resource group containing the Key Vault
# variable "data_resource_group_name" {
#   description = "The name of the resource group containing the Key Vault."
#   type        = string
# }

# Name of the User Assigned Identity (UAID) for resource authentication
variable "uaid_name" {
  description = "Name of the User Assigned Identity."
  type        = string
  default     = "ict-platform-ccai-uaid"
}
