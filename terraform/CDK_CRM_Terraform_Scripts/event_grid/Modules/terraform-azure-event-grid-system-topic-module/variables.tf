#variables.tf
# Variables for the EventGrid System Topic Module
variable "name" {
  description = "The name of the EventGrid System Topic"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{1,48}[a-zA-Z0-9]$", var.name))
    error_message = "EventGrid System Topic name must be 3-50 characters long, start and end with alphanumeric characters, and can contain hyphens."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the EventGrid System Topic"
  type        = string
}

variable "location" {
  description = "The Azure location where the EventGrid System Topic should be created"
  type        = string
}

variable "source_arm_resource_id" {
  description = "The ID of the Azure Resource which will be used as the source of events"
  type        = string
}

variable "topic_type" {
  description = "The topic type of the EventGrid System Topic"
  type        = string
  validation {
    condition = contains([
      "Microsoft.Storage.StorageAccounts",
      "Microsoft.EventHub.Namespaces",
      "Microsoft.Resources.Subscriptions",
      "Microsoft.Resources.ResourceGroups",
      "Microsoft.ServiceBus.Namespaces",
      "Microsoft.KeyVault.vaults",
      "Microsoft.Web.Sites",
      "Microsoft.ContainerRegistry.Registries",
      "Microsoft.Devices.IoTHubs",
      "Microsoft.MachineLearningServices.Workspaces",
      "Microsoft.Media.MediaServices",
      "Microsoft.Maps.Accounts",
      "Microsoft.Cache.Redis",
      "Microsoft.Communication.CommunicationServices",
      "Microsoft.HealthcareApis.Services",
      "Microsoft.EventGrid.Domains",
      "Microsoft.EventGrid.Topics",
      "Microsoft.SignalRService.SignalR",
      "Microsoft.AppConfiguration.ConfigurationStores"
    ], var.topic_type)
    error_message = "Topic type must be a valid Azure service type that supports EventGrid system topics."
  }
}

variable "identity" {
  description = "Identity configuration for the EventGrid System Topic"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
  validation {
    condition = var.identity == null || contains([
      "SystemAssigned",
      "UserAssigned",
      "SystemAssigned, UserAssigned"
    ], var.identity.type)
    error_message = "Identity type must be one of: SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the EventGrid System Topic"
  type        = map(string)
  default     = {}
}
