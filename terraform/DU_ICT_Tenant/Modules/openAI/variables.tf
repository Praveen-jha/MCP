# The name of the Azure Cognitive Services account.
# This will be the unique name for the Cognitive Services instance.
variable "Cognitive_account_Name" {
  type        = string
  description = "The name of the Azure Cognitive Services account."
}

# The Azure region where the Cognitive Services account will be deployed.
# Example values: 'East US', 'West Europe', 'Southeast Asia'.
variable "location" {
  type        = string
  description = "The Azure region where the Cognitive Services account will be deployed."
}

# The name of the resource group where the Cognitive Services account will reside.
# Ensure this resource group exists before creating the account.
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Cognitive Services account will be created."
}

# The kind/type of the Cognitive Services account.
# Example values: 'CognitiveServices', 'ComputerVision', 'TextAnalytics'.
variable "kind" {
  type        = string
  description = "The kind or type of the Cognitive Services account (e.g., 'CognitiveServices', 'TextAnalytics')."
}

# Specifies the SKU for the Cognitive Services account.
# Example: 'S0', 'S1' for standard tiers.
variable "sku_name" {
  type        = string
  description = "The SKU for the Cognitive Services account, specifying the pricing tier."
}

# Determines whether public network access is enabled for the Cognitive Services account.
# Set to true to allow public access, false to disable public network access.
variable "public_network_access_enabled" {
  type        = bool
  description = "Specifies whether public network access is enabled for the Cognitive Services account."
}

# A custom subdomain for the Cognitive Services account's endpoint.
# This allows the user to create a custom domain for the service.
variable "custom_subdomain_name" {
  type        = string
  description = "The custom subdomain name for the Cognitive Services account's endpoint."
}

# The name of the GPT-4 OpenAI deployment.
variable "deployment_name" {
  type        = string
  description = "The unique name for the GPT-4 deployment."
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

# The ptu model name for the GPT-4 deployment.
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

variable "openai_tags" {
  description = "Tags for OpenAI resource block."
  type = map(string)
}

variable "identity_type" {
  description = "The type of managed identity"
  type        = string
}

variable "identity_ids" {
  description = "The list of identity IDs"
  type        = list(string)
}