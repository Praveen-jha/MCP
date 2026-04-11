variable "runbookName" {
  description = "The name of the automation runbook."
  type        = string
}

variable "location" {
  description = "The location of the resource."
  type        = string
}

variable "rgName" {
  description = "The name of the resource group."
  type        = string
}

variable "automationAccountName" {
  description = "The name of the automation account."
  type        = string
}

variable "logVerbose" {
  description = "Specifies whether to log verbose messages."
  type        = bool
  default     = true
}

variable "logProgress" {
  description = "Specifies whether to log progress messages."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
}

variable "runbookType" {
  description = "The type of the runbook. Possible values are 'Graph', 'PowerShell', 'PowerShellWorkflow', 'Python2', 'Python3'."
  type        = string
}

variable "content" {
  description = "The content of the runbook."
  type        = string
}
