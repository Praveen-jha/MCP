variable "automationAccountName" {
  description = "The name of the Automation Account."
  type        = string
}

variable "location" {
  description = "The location where the resource will be created."
  type        = string
}

variable "rgName" {
  description = "The name of the resource group."
  type        = string
}

variable "sku" {
  description = "The SKU name of the Automation Account. Possible values are 'Basic' and 'Free'."
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
