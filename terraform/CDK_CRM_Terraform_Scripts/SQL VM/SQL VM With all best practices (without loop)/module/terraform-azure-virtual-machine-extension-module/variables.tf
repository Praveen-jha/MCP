// variables.tf
// This file defines the input variables for the azurerm_virtual_machine_extension module.

variable "virtual_machine_extension_name" {
  description = "(Required) The name of the virtual machine extension."
  type        = string
}

variable "virtual_machine_id" {
  description = "(Required) The ID of the Virtual Machine."
  type        = string
}

variable "virtual_machine_extension_publisher" {
  description = "(Required) The publisher of the extension."
  type        = string
}

variable "virtual_machine_extension_type" {
  description = "(Required) The type of extension."
  type        = string
}

variable "virtual_machine_extension_type_handler_version" {
  description = "(Required) Specifies the version of the extension to use."
  type        = string
}

variable "virtual_machine_extension_tags" {
  description = "(Optional) Tags to assign to the extension resource."
  type        = map(string)
}

variable "virtual_machine_extension_auto_upgrade_minor_version" {
  description = "(Optional) Specifies if the platform deploys the latest minor version update."
  type        = bool
  default     = null
  nullable    = true
}

variable "virtual_machine_extension_automatic_upgrade_enabled" {
  description = "(Optional) Should the extension be automatically updated when a new version is released?"
  type        = bool
  default     = null
  nullable    = true
}

variable "virtual_machine_extension_failure_suppression_enabled" {
  description = "(Optional) Should failures from the extension be suppressed?"
  type        = bool
  default     = false
}

variable "virtual_machine_extension_protected_settings" {
  description = "(Optional) The protected settings passed to the extension."
  type        = map(any)
  default     = {}
  nullable    = true
}

variable "virtual_machine_extension_protected_settings_from_key_vault" {
  description = "(Optional) The Key Vault reference block for protected settings."
  type = object({
    secret_url      = string
    source_vault_id = string
  })
  default = null
  nullable = true
}

variable "virtual_machine_extension_provision_after_extensions" {
  description = "(Optional) Names of extensions that must be provisioned before this one."
  type        = list(string)
  default     = null
}

variable "virtual_machine_extension_settings" {
  description = "(Optional) The settings passed to the extension, these are specified as a JSON object in a string."
  type        = string
  default     = null
}