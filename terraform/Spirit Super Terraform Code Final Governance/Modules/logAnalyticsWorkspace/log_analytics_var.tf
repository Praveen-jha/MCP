variable "rgName" {
  type        = string
  description = "The name of the Azure resource group where the Log Analytics Workspace will be created."
}

variable "logWorkspaceName" {
  type        = string
  description = "The name of the Log Analytics Workspace."
}

variable "location" {
  type        = string
  description = "The Azure region where the Log Analytics Workspace will be deployed."
}

variable "logWorkspaceSku" {
  type        = string
  description = "The SKU (pricing tier) for the Log Analytics Workspace."
}

variable "logRetentionInDays" {
    type = number
    description = "The retention is days for auditing, diagnostic and metric logs per your organizations requirements. Default = 180 days"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Log Analytics Workspace."
}
