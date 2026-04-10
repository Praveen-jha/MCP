// variables.tf
// This file defines the input variables for the azurerm_service_plan module.

variable "app_service_plan_name" {
  description = "(Required) Specifies the name of the App Service Plan."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the App Service Plan."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "os_type" {
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values are Windows, Linux, and WindowsContainer."
  type        = string
  validation {
    condition     = contains(["Windows", "Linux", "WindowsContainer"],var.os_type)
    error_message = "The os_type must be one of 'Windows', 'Linux', or 'WindowsContainer'."
  }
}

variable "sku_name" {
  description = "(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I1mv2, I2v2, I2mv2, I3v2, I3mv2, I4v2, I4mv2, I5v2, I5mv2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1."
  type        = string
  validation {
    condition = contains([
      "B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I1mv2", "I2v2", "I2mv2",
      "I3v2", "I3mv2", "I4v2", "I4mv2", "I5v2", "I5mv2", "I6v2", "P1v2", "P2v2", "P3v2",
      "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3",
      "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "FC1", "WS1", "WS2", "WS3", "Y1"
    ], var.sku_name)
    error_message = "The sku_name must be one of the supported Azure App Service Plan SKUs."
  }
}

variable "app_service_environment_id" {
  description = "(Optional) The ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU."
  type        = string
  default     = null
}

variable "premium_plan_auto_scale_enabled" {
  description = "(Optional) Should automatic scaling be enabled for the Premium SKU Plan. Defaults to false. Cannot be set unless using a Premium SKU."
  type        = bool
  default     = false
}

variable "maximum_elastic_worker_count" {
  description = "(Optional) The maximum number of workers to use in an Elastic SKU Plan or Premium Plan that have premium_plan_auto_scale_enabled set to true."
  type        = number
  default     = null
}

variable "worker_count" {
  description = "(Optional) The number of Workers (instances) to be allocated. Defaults to 1 if not specified and the SKU allows it."
  type        = number
  default     = null 
}

variable "per_site_scaling_enabled" {
  description = "(Optional) Should Per Site Scaling be enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "(Optional) Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
