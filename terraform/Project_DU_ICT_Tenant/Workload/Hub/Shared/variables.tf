# The number of days to retain the logs in the Log Analytics workspace.
variable "log_retention_in_days" {
  type        = number
  description = "Number of days to retain the logs in the Log Analytics workspace"
}

# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a resource group should be created or existing resource group is used."
}

# Variable for the organization name
variable "tenant_name" {
  type        = string
  description = "The tenant name of the organization."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

# Log Analytics tags to be applied
variable "logAnalytics_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Log Analytics Workspace."
}

# # List of Private DNS Zone IDs for Azure Data Lake Storage (ADLS) Blob access.
# # This is used to configure private DNS settings for blob storage endpoints within a private network.
# variable "sa_blob_private_dns_zone_id" {
#   type        = list(string)
#   description = "List of Private DNS Zone IDs associated with ADLS Blob endpoints for private network access."
# }

# variable "storage_account_name" {
#   type        = string
#   description = "The name of the storage account."
# }

# variable "storage_account_resource_group" {
#   type        = string
#   description = "The name of the resource group where the storage account is located."
# }

# # The name of the subnet to retrieve information for.
# variable "pep_subnet_name" {
#   type        = string
#   description = "The name of the subnet."
# }

# # The name of the virtual network containing the subnet.
# variable "pep_virtual_network_name" {
#   type        = string
#   description = "The name of the virtual network containing the subnet."
# }

# # The name of the resource group where the virtual network and subnet reside.
# variable "pep_resource_group_name" {
#   type        = string
#   description = "The name of the resource group where the virtual network and subnet are located."
# }
