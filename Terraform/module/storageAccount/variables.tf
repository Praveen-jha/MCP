variable "storage_account_name" {
  description = "The name of the Azure Storage Account."
  type        = string
}
variable "account_tier" {
  description = "The storage account tier (Standard or Premium)."
  type        = string
}
variable "rg_name" {
  description = "The name of the Resource Group for the storage account."
  type        = string
}
variable "location" {
  description = "The location of the storage account."
  type        = string
}
variable "account_replication_type" {
  description = "The storage account replication type (LRS, GRS, RAGRS, ZRS, GZRS, or GZRS)."
  type        = string
}
variable "tags" {
  description = "A map of tags to assign to the Azure Storage Account."
  type        = map(string)
}
variable "is_hns_enabled" {
  description = "Boolean flag to enable hierarchical namespace for the storage account."
  type        = bool
}
variable "public_network_access_enabled" {
  description = "Boolean flag to enable public network access for the storage account."
  type        = bool
}
variable "account_kind" {
  description = "Defines the Kind of the storage account."
  type        = string
}
variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
}
variable "network_rules" {
  description = "Network rules configuration for the storage account."
  type        = any
  default     = {}
}
variable "storage_account_identity_type" {
  description = "identity type for the storage Account"
  type        = string
  default     = "SystemAssigned"
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled?"
  type =   bool
  default = true
}