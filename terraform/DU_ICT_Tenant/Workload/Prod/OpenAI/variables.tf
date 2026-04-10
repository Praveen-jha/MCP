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

variable "sku_name" {
  type        = string
  description = "SKU for the OpenAI"
}

# The Azure AD tenant name where the resources are deployed.
# This is important for resource isolation and access management.
variable "tenant_name" {
  type        = string
  description = "The name of the Azure AD tenant where the resources will be deployed. It is typically used for resource isolation and management."
}

# The environment tag used for naming and identifying resources.
# Common values include 'dev', 'test', and 'prod'.
variable "environment" {
  type        = string
  description = "The environment for resource deployment (e.g., 'dev', 'prod'). This is used for resource naming and tagging to help identify the stage of the resources."
}

# Variable for the Business unit name
variable "bu_name" {
  type        = string
  description = "The name of the Business unit."
}

# The SKU name for the deployment.
variable "ptu_sku_name" {
  type        = string
  description = "The SKU required for Provisioned Throughput Unit (PTU) deployment. Example: 'ProvisionedManaged'."
}

# The desired capacity for the deployment SKU.
variable "ptu_sku_capacity" {
  type        = number
  description = "The capacity for the SKU. Adjust this number based on resource requirements."
}

# The model format to be used.
variable "model_format" {
  type        = string
  description = "The format of the model to deploy, e.g., 'OpenAI'."
}

# The model name for the GPT-4 deployment.
variable "model_name" {
  type        = string
  description = "The name of the model being deployed, e.g., 'gpt-4o'."
}

# The version of the model to be deployed.
variable "model_version" {
  type        = string
  description = "The version of the model for deployment. Update as needed."
}

# The name of the embedding deployment. This should be unique within your Azure resources.
variable "embedding_deployment_name" {
  description = "The name of the embedding deployment."
  type        = string
}

# The SKU name for the embedding model (e.g., 'Standard', 'Premium'). This determines the pricing tier and performance characteristics.
variable "embedding_sku_name" {
  description = "The SKU name for the embedding model (e.g., 'Standard', 'Premium')."
  type        = string
}

# The capacity for the embedding model in tokens per minute (TPM). This sets the maximum number of tokens that can be processed per minute.
variable "embedding_sku_capacity" {
  description = "The capacity for the embedding model in tokens per minute (TPM)."
  type        = number
}

# The name of the embedding model to deploy. Specify the exact name of the model you wish to use, such as 'text-embedding-ada-002'.
variable "embedding_model_name" {
  description = "The name of the embedding model to deploy."
  type        = string
}

# The version of the embedding model to deploy. Indicate which version you want to deploy, e.g., 'latest' or a specific version number.
variable "embedding_model_version" {
  description = "The version of the embedding model to deploy."
  type        = string
}

# ID of the centralized Log Analytics workspace
variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the centralized Log Analytics workspace used for monitoring and logging."
}

# Tags for the OpenAI resource
variable "openai_tags" {
  description = "Tags to be assigned to the OpenAI resource block."
  type        = map(string)
}

# Type of managed identity (e.g., SystemAssigned, UserAssigned)
variable "identity_type" {
  type        = string
  description = "The type of managed identity to assign to the resource (e.g., SystemAssigned, UserAssigned)."
}

# Name of the User Assigned Identity (UAID)
variable "uaid_name" {
  type        = string
  description = "The name of the User Assigned Identity (UAID)."
}

# Name of the Azure Key Vault
variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

# Name of the resource group containing the Key Vault
variable "data_resource_group_name" {
  description = "The name of the resource group containing the Azure Key Vault."
  type        = string
}

# Name of the specific key within the Key Vault to retrieve
variable "key_vault_key_name" {
  description = "The name of the specific key to retrieve from the Key Vault."
  type        = string
}
