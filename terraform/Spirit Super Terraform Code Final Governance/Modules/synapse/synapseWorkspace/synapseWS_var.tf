variable "synapseWorkspaceName" {
  type = string
  description = "Name of the Synapse Workspace to be created."
}

variable "rgName" {
  type        = string
  description = "The name of the Azure Resource Group where the Virtual Network will be created."
}

variable "location" {
  type        = string
  description = "The location (region) where the Azure Virtual Network will be created."
}

variable "publicNetworkAccessEnabled" {
  type        = bool
  description = "Public network access is allowed for this Synapse Workspace."
}

variable "managedVirtualNetworkEnabled" {
  type = bool
  description = "Is data exfiltration protection enabled in this workspace? If set to true, managed_virtual_network_enabled must also be set to true."
}

variable "fileSystemId" {
  type = string
  description = " Specifies the ID of storage data lake gen2 filesystem resource. Changing this forces a new resource to be created."
}

variable "sqlAdminUserName" {
  type = string
  description = "Specifies The login name of the SQL administrator. Changing this forces a new resource to be created."
}

variable "sqlAdminPassword" {
  type = string
  description = "The Password associated with the sql_administrator_login for the SQL administrator."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Synapse Workspace."
}
