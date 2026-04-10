// output.tf
// This file defines the output values for the azurerm_service_plan module.

output "app_service_plan" {
  description = "The entire resource object for the App Service Plan."
  value       = azurerm_service_plan.this
}

output "app_service_plan_id" {
  description = "The ID of the Service Plan."
  value       = azurerm_service_plan.this.id
}

output "app_service_plan_name" {
  description = "The name of the Service Plan."
  value       = azurerm_service_plan.this.name
}

output "app_service_plan_location" {
  description = "The Azure Region where the Service Plan exists."
  value       = azurerm_service_plan.this.location
}

output "app_service_plan_kind" {
  description = "A string representing the Kind of Service Plan."
  value       = azurerm_service_plan.this.kind
}

output "app_service_plan_os_type" {
  description = "The O/S type for the App Services hosted in this plan."
  value       = azurerm_service_plan.this.os_type
}

output "app_service_plan_sku_name" {
  description = "The SKU for the Service Plan."
  value       = azurerm_service_plan.this.sku_name
}

output "app_service_plan_reserved" {
  description = "Whether this is a reserved Service Plan Type. True if os_type is Linux, otherwise false."
  value       = azurerm_service_plan.this.reserved
}

output "app_service_plan_maximum_elastic_worker_count" {
  description = "The maximum number of workers in use in an Elastic SKU Plan."
  value       = azurerm_service_plan.this.maximum_elastic_worker_count
}

output "app_service_plan_worker_count" {
  description = "The number of Workers (instances) allocated."
  value       = azurerm_service_plan.this.worker_count
}

output "app_service_plan_per_site_scaling_enabled" {
  description = "Is Per Site Scaling enabled?"
  value       = azurerm_service_plan.this.per_site_scaling_enabled
}

output "app_service_plan_zone_balancing_enabled" {
  description = "Is the Service Plan balance across Availability Zones in the region?"
  value       = azurerm_service_plan.this.zone_balancing_enabled
}
