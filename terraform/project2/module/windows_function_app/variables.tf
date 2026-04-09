# REQUIRED VARIABLES (variables which are needed to be passed)
variable "fa_name" {
  description = "The name which should be used for this Windows Function App"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group where the Windows Function App should exist"
  type        = string
}

variable "location" {
  description = "The Azure Region where the Windows Function App should exist"
  type        = string
}

variable "asp_id" {
  description = "The ID of the App Service Plan within which to create the Function App"
  type        = string
}

# OPTIONAL VARIABLES (variables which are not necessary to be passed)
variable "storage_account_name" {
  description = "The backend storage account name which will be used by the Function App"
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key which will be used to access the backend storage account for the Function App"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "virtual_network_subnet_id" {
  description = "The subnet ID which will be used by the Function App for regional virtual network integration"
  type        = string
}

variable "vnet_route_all_enabled" {
  description = "Defines all outbound traffic to have NAT Gateways, Network Security Groups, and User Defined Routes applied"
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Defines whether public network access should be enabled for the Function App"
  type        = bool
  default     = false
}

variable "always_on" {
  description = "Defines if the Windows Web App is Always On enabled"
  type        = bool
}

variable "use_32_bit_worker" {
  description = "Defines whether the Windows Web App uses a 32-bit worker process"
  type        = bool
}

variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be configured"
  type        = string
}

variable "dotnet_stack" {
  description = "The version of .NET to use"
  type = object({
    dotnet_version = string
  })
}

variable "elastic_instance_minimum" {
  description = "The number of minimum instances for the Windows Function App"
  type        = number
}
