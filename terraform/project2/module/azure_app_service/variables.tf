variable "app_service_plan_name" {
  description = "The name of the Azure App Service Plan."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the App Service Plan will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the App Service Plan will be deployed."
  type        = string
}

variable "sku_name" {
  description = "The pricing tier of the App Service Plan (e.g., 'PremiumV2', 'Dynamic')."
  type        = string
}

variable "os_type" {
  description = "Specifies the operating system type for the Kubernetes node pool (e.g., Linux or Windows)."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}

variable "zone_balancing_enabled" {
  description = "Specifies whether zone balancing is enabled for the AKS cluster, ensuring an even distribution of nodes across availability zones."
  type        = bool
}

variable "maximum_elastic_worker_count" {
  description = "The maximum number of worker"
  type        = number
}
