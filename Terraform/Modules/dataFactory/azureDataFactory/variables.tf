variable "data_factory_name" {
  description = "(Required) Specifies the name of the Data Factory"
  type        = string
}

variable "data_factory_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "data_factory_rg" {
  description = "(Required) The name of the resource group in which to create the Data Factory."
  type        = string
}
variable "public_network_enabled" {
  type    = bool
}
variable "managed_virtual_network_enabled" {
  description = "Specifies whether the Managed Virtual Network feature is enabled for the Azure Data Factory. Setting this to 'true' enables secure network traffic between data sources."
  type        = bool
}

variable "identity_type" {
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this Data Factory. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  type        = string
}

variable "customer_managed_key_id" {
  description = "(Optional) Specifies the Azure Key Vault Key ID to be used as the Customer Managed Key (CMK) for double encryption. Required with user assigned identity."
  type        = string
  nullable    = true
  default     = null
}

variable "github_configuration" {
  description = "Map of GitHub configurations."
  type = map(object({
    account_name       = string
    branch_name        = string
    git_url            = optional(string, null)
    repository_name    = string
    root_folder        = string
    publishing_enabled = optional(bool, null)
  }))
  default = {}
}

variable "tags" {
  description = "Tags for the ADF"
  type        = map(string)
}
