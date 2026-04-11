variable "runbookName" {
  description = "The name of the automation runbook."
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

variable "scheduleName" {
  description = "The name of the schedule."
  type        = string
}

variable "frequency" {
  description = "The frequency of the schedule. Possible values are 'OneTime', 'Day', 'Hour', 'Month', 'Week'."
  type        = string
}

variable "interval" {
  type = string
}

variable "timezone" {
  description = "The timezone of the schedule."
  type        = string
}

variable "startTime" {
  description = "The start time of the schedule in ISO 8601 format."
  type        = string
}

variable "vmnames" {
   description = "The Name of Azure Virtual Machine."
  type = string
}

variable "rgNameVM" {
  description = " The Name of Resource Group where Virtual Machine deployed."
type = string
}

