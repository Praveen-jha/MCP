variable "law_name" {
  type = string
  description = "Name of log analytics workspace"
}

variable "law_location" {
  type = string
  description = "Location of log analytics workspace"
}

variable "law_resource_group" {
  type = string
  description = "Resource group name of log analytics workspace"
}

variable "law_retention_days" {
  type = number
  description = "Number of retention days for log analytics workspace"
}

variable "law_tags" {
  type = map(string)
  description = "Tags for log analytics workspace"
}