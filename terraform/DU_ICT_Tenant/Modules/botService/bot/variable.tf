variable "bot_name" {
  description = "The name of the Azure Bot Service."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location for the Azure Bot Service."
  type        = string
}

variable "microsoft_app_id" {
  description = "The Microsoft App ID."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Bot Service."
  type        = string
}

variable "endpoint" {
  description = "The endpoint URL for the Azure Bot Service."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Enable public network access."
  type        = string
}

variable "local_authentication_enabled" {
  description = "Enable local authentication."
  type        = bool
}

variable "tags" {
  description = "Tags for the Azure Bot Service."
  type        = map(string)
}
