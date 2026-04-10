# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Variable for the subscription
# variable "subscription_id" {
#   type        = string
#   description = "The name of the subscription_id"
# }

# The geographical location where the resource group will be deployed.
variable "ai_rg_location" {
  type        = string
  description = "Location of the resource group."
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

variable "speech_service_sku" {
  type        = string
  description = "The SKU tier for the Azure Speech Service (e.g., F0 for free tier or S1 for standard tier). Determines the pricing and capabilities of the service."
}

variable "language_service_sku" {
  type        = string
  description = "The SKU tier for the Azure Language Service (e.g., F0 for free tier or S1 for standard tier). Used to configure the language service features in Cognitive Services."
}

variable "translator_service_sku" {
  type        = string
  description = "The SKU tier for the Azure Translator Service (e.g., F0 for free tier or S1 for standard tier). Defines the pricing and scale of the translator functionality."
}

variable "sku_name" {
  type        = string
  description = "SKU for the OpenAI"
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

# The name of the GPT-4 OpenAI deployment.
variable "latest_deployment_name" {
  type        = string
  description = "The unique name for the GPT-4 deployment."
}

# The SKU name for the deployment.
variable "latest_ptu_sku_name" {
  type        = string
  description = "The SKU required for Provisioned Throughput Unit (PTU) deployment. Example: 'ProvisionedManaged'."
}

# The desired capacity for the deployment SKU.
variable "latest_ptu_sku_capacity" {
  type        = number
  description = "The capacity for the SKU. Adjust this number based on resource requirements."
}

# The model format to be used.
variable "latest_model_format" {
  type        = string
  description = "The format of the model to deploy, e.g., 'OpenAI'."
}

# The ptu model name for the GPT-4 deployment.
variable "latest_model_name" {
  type        = string
  description = "The name of the model being deployed, e.g., 'gpt-4o'."
}

# The version of the model to be deployed.
variable "latest_model_version" {
  type        = string
  description = "The version of the model for deployment. Update as needed."
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of managed identity to be used. Possible values include 'SystemAssigned', 'UserAssigned', or 'None'."
}

variable "search_identity_type" {
  type        = string
  description = "Specifies the type of managed identity to be used. Possible values include 'SystemAssigned', 'UserAssigned', or 'None'."
}

# Specifies the SKU (pricing tier) of the Azure Key Vault instance.
# Common values are 'standard' for general use or 'premium' for advanced features, such as HSM-backed keys.
variable "key_vault_sku_name" {
  type        = string
  description = "The SKU (pricing tier) name for the Azure Key Vault. Options are 'standard' or 'premium'."
}

variable "key_opts" {
  description = "The options for the key."
  type        = list(string)
}

variable "key_type" {
  description = "The type of key to create."
  type        = string
}

variable "key_size" {
  description = "The size of the key in bits."
  type        = number
}
# The name of the subnet to retrieve information for.
variable "pep_subnet_name" {
  type        = string
  description = "The name of the subnet."
}

# # Specifies a list of Private DNS Zone IDs to associate with the Azure Key Vault.
# # Used to configure private DNS settings for accessing the Key Vault within a private network.
# variable "key_vault_private_dns_zone_id" {
#   type        = list(string)
#   description = "A list of Private DNS Zone IDs to associate with the Key Vault for private network access."
# }

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

#A map of common tags to assign resources.
variable "tags" {
  type        = map(string)
  description = "A map of common tags to assign resources."
}

// REQUIRED VARIABLES for Document Intelligence Cognitive Service will be created
variable "di" {
  type = object({
    di_kind                          = string
    di_skuname                       = string
    pep_target_subresources          = list(string)
    public_network_access_enabled_di = bool
    identity_type                    = string
    di_tags                          = map(string)
  })
}

# The ID of the private DNS zone for the cognitive_account / Document Intelligence.
variable "document_intelligence_private_dns_zone_ids" {
  description = "The ID of the private DNS zone for the cognitive_account / Document Intelligence."
  type        = list(string)
}

#REQUIRED VARIABLES for ML compute instance configuraiton
# variable "ml_vm_configs" {
#   description = "Map of machine_learning_workspace VM configurations"
#   type = map(object({
#     ml_compute_vm_size     = string      #Size of the VM for Machine Learning compute instance
#     ml_compute_tags        = map(string) #Tags for the Machine Learning compute instance
#     node_public_ip_enabled = bool        #For public IP enabled or disabled
#     object_id_user         = string      #Users AAD Object Id
#     tenant_id              = string      #Azure tenant id where user ID Exists
#   }))
# }

# The name of the resource group where the Log Analytics workspace is located.
variable "log_analytics_resource_group_name" {
  description = "The name of the resource group where the Log Analytics workspace is located."
  type        = string
}

# The name of the Log Analytics workspace.
variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace."
  type        = string
}

# The name of the subnet to retrieve information for.
# variable "ml_compute_instance_subnet_name" {
#   type        = string
#   description = "The name of the subnet."
# }

# # The name of the virtual network containing the subnet.
# variable "ml_compute_instance_vnet_name" {
#   type        = string
#   description = "The name of the virtual network containing the subnet."
# }

# # The name of the resource group where the virtual network and subnet reside.
# variable "ml_compute_instance_network_rg" {
#   type        = string
#   description = "The name of the resource group where the virtual network and subnet are located."
# }

# # The ID of the private DNS zone for the AML workspace.
# variable "ml_workspace_private_dns_zone_id" {
#   description = "The ID of the private DNS zone for the AML workspace."
#   type        = list(string)
# }

# # List of Private DNS Zone IDs for Azure Data Lake Storage (ADLS) Blob access.
# # This is used to configure private DNS settings for blob storage endpoints within a private network.
# variable "adls_blob_private_dns_zone_id" {
#   type        = list(string)
#   description = "List of Private DNS Zone IDs associated with ADLS Blob endpoints for private network access."
# }

# # List of Private DNS Zone IDs for Azure Data Lake Storage (ADLS) File access.
# # This is used to configure private DNS settings for File storage endpoints within a private network.
# variable "adls_file_private_dns_zone_id" {
#   type        = list(string)
#   description = "List of Private DNS Zone IDs associated with ADLS File endpoints for private network access."
# }

# # List of Private DNS Zone IDs for Azure Data Lake Storage (ADLS) Data File System (DFS) access.
# # This is used to set up private DNS for DFS endpoints within a private network.
# variable "adls_dfs_private_dns_zone_id" {
#   type        = list(string)
#   description = "List of Private DNS Zone IDs associated with ADLS DFS endpoints for private network access."
# }

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

#Variable to define name of log analytics workspace
variable "law_name" {
  type        = string
  description = "Name of log analytics workspace"
}

#Variable to define rg name of log analytics workspace
variable "law_rg_name" {
  type        = string
  description = "Name of rg of log analytics workspace"
}
# changes
variable "ai_search_sku" {
  type        = string
  description = "SKU of rg of Azure AI Search"
}
variable "semantic_search_sku" {
  description = "The SKU name for the semantic search capability. Accepted values are 'Standard', 'Free', or leave empty to disable."
  type        = string
  default     = null
}
variable "authentication_failure_mode" {
  type        = string
  description = "Specifies the behavior when authentication fails for the Azure Search Service."
}

variable "customer_managed_key_enforcement_enabled" {
  type        = bool
  description = "nnnn."
}

# Tags for the Azure Search resource block.
variable "ai_search_tags" {
  type        = map(string)
  description = "Tags for the Azure Search resource block."
}

variable "container_registry" {
  type = object({
    sku                           = string
    public_network_access_enabled = bool
    identity = object({
      type = string
    })
    tags = map(string)
  })
}

# variable "acr_private_dns_zone_id" {
#   description = "Private DNS Zone ID of the Azure Container Registry Endpoint."
#   type        = list(string)
# }

variable "hub_acr_private_dns_zone_id" {
  description = "Private DNS Zone ID of the Azure Container Registry Endpoint."
  type        = list(string)
}

variable "apim_public_ip_name" {
  type = string
}

variable "apim_subnet_name" {
  type = string
}

variable "hub_pep_subnet_name" {
  type = string
}

variable "hub_pep_virtual_network_name" {
  type = string
}

variable "hub_pep_subnet_id" {
  type = string
}

variable "hub_pep_resource_group_name" {
  type = string
}
variable "apim_config" {
  description = "Configuration object for Azure API Management. Includes all publisher, networking, identity and other properties."
  type = object({
    publisher_name                = string
    publisher_email               = string
    sku_name                      = string
    public_network_access_enabled = bool
    virtual_network_type          = string
    tags                          = map(string)

    identity = object({
      type = string
    })
  })
}
