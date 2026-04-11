variable "purviewName" {
  type = string
  description = "Name of the Purview Account to be created."
}

variable "resourceGroupName" {
  type = string
  description = "The name of the Azure Resource Group where the Purview Account will be created."
}

variable "purviewManagedRGName" {
  type = string
  description = "The name of the Managed Resource Group of Purview Account."
}

variable "location" {
  type = string
  description = "The location (region) where the Purview Account will be created."
}

variable "publicNetworkEnabled" {
  type = string
  description = "Public network access is allowed for this Purview Account."
}

variable "tags" {
  description = "A map of tags to assign to the Azure Purview Account."
  type        = map(string)
}
