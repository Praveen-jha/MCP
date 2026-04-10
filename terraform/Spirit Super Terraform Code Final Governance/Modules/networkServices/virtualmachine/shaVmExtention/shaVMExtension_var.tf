variable "vmExtensionName" {
  type = string
  description = "The name which should be used for this Synapse Self-hosted Integration Runtime."
}

variable "virtualMachineId" {
  type = string
  description = "Virtual Machien Resource ID."
}

variable "devOpsUrl" {
  type = string
  description = "DevOps Organisation URL."
}

variable "devOpsTenantId" {
  type = string
  description = "DevOps Tenant ID."
}

variable "devOpsClientId" {
  type = string
  description = "DevOps Client ID."
}

variable "devOpsClientSecret" {
  type = string
  description = "DevOps Client Secret."
}

variable "devOpsPool" {
  type = string
  description = "DevOps Agnet Pool Name."
}

variable "templateFile" {
  type = string
  description = "Template File."
}