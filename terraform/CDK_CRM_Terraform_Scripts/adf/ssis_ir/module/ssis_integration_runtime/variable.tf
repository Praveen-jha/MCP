#variables.tf
# This file defines the variables used in the SSIS Integration Runtime module for Azure.
variable "name" {
  description = "Specifies the name of the Azure-SSIS Integration Runtime"
  type        = string
}

variable "data_factory_id" {
  description = "The Data Factory ID in which to associate the Integration Runtime with"
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
  type        = string
}

variable "node_size" {
  description = "The size of the nodes on which the Azure-SSIS Integration Runtime runs"
  type        = string
  validation {
    condition = contains([
      "Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2",
      "Standard_D2_v3", "Standard_D4_v3", "Standard_D8_v3", "Standard_D16_v3",
      "Standard_D32_v3", "Standard_D64_v3", "Standard_E2_v3", "Standard_E4_v3",
      "Standard_E8_v3", "Standard_E16_v3", "Standard_E32_v3", "Standard_E64_v3",
      "Standard_A4_v2", "Standard_A8_v2"
    ], var.node_size)
    error_message = "node_size must be a valid Azure VM size for SSIS Integration Runtime."
  }
}

# Optional variables
variable "description" {
  description = "Integration runtime description"
  type        = string
  default     = null
}

variable "edition" {
  description = "The Azure-SSIS Integration Runtime edition. Valid values: Standard, Enterprise"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Enterprise"], var.edition)
    error_message = "edition must be Standard or Enterprise."
  }
}

variable "license_type" {
  description = "The type of the license that is used. Valid values: LicenseIncluded, BasePrice"
  type        = string
  default     = "LicenseIncluded"
  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "license_type must be LicenseIncluded or BasePrice."
  }
}

variable "max_parallel_executions_per_node" {
  description = "Defines the maximum parallel executions per node"
  type        = number
  default     = 1
  validation {
    condition     = var.max_parallel_executions_per_node >= 1 && var.max_parallel_executions_per_node <= 8
    error_message = "max_parallel_executions_per_node must be between 1 and 8."
  }
}

variable "number_of_nodes" {
  description = "Number of nodes for the Azure-SSIS Integration Runtime"
  type        = number
  default     = 1
  validation {
    condition     = var.number_of_nodes >= 1 && var.number_of_nodes <= 10
    error_message = "number_of_nodes must be between 1 and 10."
  }
}

variable "credential_name" {
  description = "The name of the credential used for the Azure-SSIS Integration Runtime"
  type        = string
  default     = null
}

# Complex optional variables
variable "catalog_info" {
  description = "A catalog_info block for the SSIS Integration Runtime"
  type = object({
    server_endpoint        = string           //(Required) The endpoint of an Azure SQL Server that will be used to host the SSIS catalog.
    administrator_login    = optional(string) //(Optional) Administrator login name for the SQL Server.
    administrator_password = optional(string) //(Optional) Administrator login password for the SQL Server.
    pricing_tier           = optional(string) //Pricing tier for the database that will be created for the SSIS catalog. 
    dual_standby_pair_name = optional(string) //(Optional) The dual standby Azure-SSIS Integration Runtime pair with SSISDB failover.
    elastic_pool_name      = optional(string) //(Optional) The name of SQL elastic pool where the database will be created for the SSIS catalog.
  })
  default = null
}

variable "vnet_integration" {
  description = "A vnet_integration block for the SSIS Integration Runtime"
  type = object({
    vnet_id     = optional(string)
    subnet_name = optional(string)
    subnet_id   = optional(string)
    public_ips  = optional(list(string))
  })
  default = null
}
