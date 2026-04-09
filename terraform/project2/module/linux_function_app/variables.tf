# REQUIRED VARIABLES (variables which are needed to be passed)
variable "name" {
  description = "The name which should be used for this Linux Function App"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group where the Linux Function App should exist"
  type        = string
}

variable "location" {
  description = "The Azure Region where the Linux Function App should exist"
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

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "virtual_network_subnet_id" {
  description = "The subnet ID which will be used by the Function App for regional virtual network integration"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Defines whether public network access should be enabled for the Function App"
  type        = bool
  default     = false
}

variable "https_only" {
  description = "Enforce HTTPS-only traffic for the resource. Set to true to disable HTTP connections."
  type        = bool
}

variable "function_identity" {
  description = "Type of Managed Service Identity that should be configured on the app service"
  type = object({
    type         = string
    identity_ids = list(string)
  })
}

variable "storage_uses_managed_identity" {
  description = "Specifies whether the function app should use a managed identity for storage"
  type        = bool
  default     = true
}
