variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "tags" {
  description = "Tags for OpenAI resource block."
  type = map(string)
}
