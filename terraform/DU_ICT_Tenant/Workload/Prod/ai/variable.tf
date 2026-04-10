# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# The geographical location where the resource group will be deployed.
variable "ai_rg_location" {
  type        = string
  description = "Location of the resource group."
}

# The SKU for the Azure Search Service.
variable "ai_search_sku" {
  type        = string
  description = "The SKU for the Azure Search Service."
}

# Specifies the behavior when authentication fails for the Azure Search Service.
variable "authentication_failure_mode" {
  type        = string
  description = "Specifies the behavior when authentication fails for the Azure Search Service."
}

# Tags for the Azure Search resource block.
variable "ai_search_tags" {
  type        = map(string)
  description = "Tags for the Azure Search resource block."
}

# Use this variable to define tags for resources associated with the Document Intelligence Service.
variable "document_intelligence_tags" {
  type        = map(string)
  description = "A map of key-value pairs to tag resources related to Document Intelligence Service."
}

# The type of managed identity (e.g., SystemAssigned, UserAssigned).
variable "identity_type" {
  type        = string
  description = "The type of managed identity (e.g., SystemAssigned, UserAssigned)."
}

# The SKU name of the Cognitive Account for Document Intelligence.
variable "document_intelligence_sku_name" {
  type        = string
  description = "The SKU name of the Cognitive Account for Document Intelligence."
}

# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the business unit name
variable "bu_name" {
  type        = string
  description = "The name of the business unit."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

# The name of the subnet to retrieve information for.
variable "pep_subnet_name" {
  type        = string
  description = "The name of the subnet."
}

# The name of the virtual network containing the subnet.
variable "pep_virtual_network_name" {
  type        = string
  description = "The name of the virtual network containing the subnet."
}

# The name of the resource group where the virtual network and subnet reside.
variable "pep_resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual network and subnet are located."
}

# The ID of the Private DNS Zone for Azure Cognitive Search.
# This is used to configure DNS resolution for private endpoints connected to Azure Cognitive Search.
variable "ai_search_private_dns_zone_id" {
  type        = list(string)
  description = "The ID of the Private DNS Zone for Azure Cognitive Search private endpoint."
}

# The ID of the Private DNS Zone for the Azure Cognitive Services account.
# This is used to configure DNS resolution for private endpoints connected to Azure Cognitive Services.
variable "cognitive_account_private_dns_zone_id" {
  type        = list(string)
  description = "The ID of the Private DNS Zone for the Azure Cognitive Services account private endpoint."
}

# Name of the Azure Key Vault used for securing secrets
variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

# Name of the resource group containing the Key Vault
variable "data_resource_group_name" {
  description = "The name of the resource group containing the Key Vault."
  type        = string
}

# Name of the specific key stored in the Key Vault to retrieve
variable "key_vault_key_name" {
  description = "The name of the Key Vault key to retrieve."
  type        = string
}

# Name of the User Assigned Identity (UAID) for resource authentication
variable "uaid_name" {
  description = "Name of the User Assigned Identity."
  type        = string
}
