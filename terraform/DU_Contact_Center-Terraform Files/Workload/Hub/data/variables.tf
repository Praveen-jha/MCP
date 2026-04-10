# The geographical location where the resources will be deployed.
variable "location" {
  type        = string
  description = "Location of the resources."
}

# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

# Specifies the SKU (pricing tier) of the Azure Key Vault instance.
# Common values are 'standard' for general use or 'premium' for advanced features, such as HSM-backed keys.
variable "key_vault_sku_name" {
  type        = string
  description = "The SKU (pricing tier) name for the Azure Key Vault. Options are 'standard' or 'premium'."
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

# Specifies a list of Private DNS Zone IDs to associate with the Azure Key Vault.
# Used to configure private DNS settings for accessing the Key Vault within a private network.
variable "key_vault_private_dns_zone_id" {
  type        = list(string)
  description = "A list of Private DNS Zone IDs to associate with the Key Vault for private network access."
}


#A map of common tags to assign resources.
variable "tags" {
  type        = map(string)
  description = "A map of common tags to assign resources."
}

# #The options for the key.
# variable "key_opts" {
#   description = "The options for the key."
#   type        = list(string)
# }

# #The type of key to create
# variable "key_type" {
#   description = "The type of key to create."
#   type        = string
# }

# #The size of the key in bit
# variable "key_size" {
#   description = "The size of the key in bits."
#   type        = number
# }

variable "rg_creation" {
  description = "Resource Creation"
  type        = string
}

variable "location_shortname" {
  description = "Location shortname"
  type        = string
}
variable "workload_type" {
  description = "workload type of the resource"
  type        = string
}

variable "resource_group_tags" {
  description = "resource group tags"
  type        = map(string)
}

# # Specifies a list of Private DNS Zone IDs to associate with the Azure Key Vault.
# # Used to configure private DNS settings for accessing the Key Vault within a private network.
# variable "key_vault_private_dns_zone_id" {
#   type        = list(string)
#   description = "A list of Private DNS Zone IDs to associate with the Key Vault for private network access."
# }

# # The ID of the private DNS zone for the cognitive_account / Document Intelligence.
# variable "document_intelligence_private_dns_zone_ids" {
#   description = "The ID of the private DNS zone for the cognitive_account / Document Intelligence."
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

# variable "acr_private_dns_zone_id" {
#   description = "Private DNS Zone ID of the Azure Container Registry Endpoint."
#   type        = list(string)
# }
