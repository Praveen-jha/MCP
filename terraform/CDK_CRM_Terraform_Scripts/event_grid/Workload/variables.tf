variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the Function App will be created."

}
variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "name_config" {
  type = object({
    resource_group_creation  = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation          = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    storage_account_creation = string //"Flag to indicate whether a new Storage Account should be created or existing Storage Account is used."
    function_app_creation = string //"Flag to indicate whether a new Function App should be created or existing Function App is used."
    environment              = string //Deployment Environment (for example UAT or Prod).
    short_name               = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name             = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag              = string //Central US (cus), East US 2 (eus2)
    instance                 = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application              = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}


variable "existing_resource_group_name" {
  type        = string
  description = "Name of the Existing Resource Group"
}

variable "existing_virtual_network_name" {
  type        = string
  description = "Name of the Existing Virtual Network"
}

variable "existing_private_endpoint_subnet_name" {
  type        = string
  description = "Name of the Existing Inbound Subnet for App Service"
}

variable "existing_outbound_subnet_name" {
  type        = string
  description = "Name of the Existing Outbound Subnet for App Service"
}
variable "existing_function_app_name" {
  type        = string
  description = "Name of the Existing Function App"
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

# EventGrid System Topic configuration
variable "source_arm_resource_id" {
  description = "The ARM resource ID of the source for EventGrid system topic"
  type        = string
}

# EventGrid Event Subscription configuration
variable "endpoint_type" {
  description = "Type of endpoint (storage_queue, azure_function, webhook)"
  type        = string
  validation {
    condition = contains([
      "storage_queue", 
      "azure_function", 
      "webhook"
    ], var.endpoint_type)
    error_message = "Endpoint type must be one of: storage_queue, azure_function, webhook."
  }
}

variable "event_delivery_schema" {
  description = "Event delivery schema"
  type        = string
  default     = null
  validation {
    condition = var.event_delivery_schema == null || contains([
      "EventGridSchema",
      "CloudEventSchemaV1_0",
      "CustomInputSchema"
    ], var.event_delivery_schema)
    error_message = "Event delivery schema must be one of: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema."
  }
}

variable "advanced_filtering_on_arrays_enabled" {
  description = "Whether advanced filtering on arrays is enabled"
  type        = bool
  default     = null
}

variable "included_event_types" {
  description = "List of event types to include"
  type        = list(string)
  default     = null
}

variable "labels" {
  description = "List of labels for the event subscription"
  type        = list(string)
  default     = null
}

variable "expiration_time" {
  description = "Expiration time for the event subscription"
  type        = string
  default     = null
}

# Subject filter configuration
variable "subject_filter" {
  description = "Subject filter configuration for event subscription"
  type = object({
    subject_begins_with = optional(string)
    subject_ends_with   = optional(string)
    case_sensitive      = optional(bool)
  })
  default = null
}

# Advanced filters configuration
variable "advanced_filters" {
  description = "Advanced filters configuration for event subscription"
  type = object({
    string_begins_with = optional(list(object({
      key    = string
      values = list(string)
    })))
    string_contains = optional(list(object({
      key    = string
      values = list(string)
    })))
    string_ends_with = optional(list(object({
      key    = string
      values = list(string)
    })))
    string_in = optional(list(object({
      key    = string
      values = list(string)
    })))
    string_not_in = optional(list(object({
      key    = string
      values = list(string)
    })))
    number_greater_than = optional(list(object({
      key   = string
      value = number
    })))
    number_less_than = optional(list(object({
      key   = string
      value = number
    })))
    number_in = optional(list(object({
      key    = string
      values = list(number)
    })))
    bool_equals = optional(list(object({
      key   = string
      value = bool
    })))
  })
  default = null
}

# Azure Function endpoint configuration
variable "azure_function_config" {
  description = "Azure Function configuration for creating function (optional)"
  type = object({
    name = string
  })
  default = null
}

variable "azure_function_endpoint" {
  description = "Azure Function endpoint configuration for event subscription"
  type = object({
    function_id                       = optional(string)
    max_events_per_batch             = optional(number)
    preferred_batch_size_in_kilobytes = optional(number)
  })
  default = null
}

# Webhook endpoint configuration
variable "webhook_endpoint" {
  description = "Webhook endpoint configuration for event subscription"
  type = object({
    url                               = string
    base_url                          = optional(string)
    max_events_per_batch             = optional(number)
    preferred_batch_size_in_kilobytes = optional(number)
    active_directory_tenant_id        = optional(string)
    active_directory_app_id_or_uri    = optional(string)
  })
  default = null
}

# Retry and identity policies
variable "retry_policy" {
  description = "Retry policy configuration"
  type = object({
    max_delivery_attempts = number
    event_time_to_live    = number
  })
  default = null
}

variable "delivery_identity" {
  description = "Delivery identity configuration"
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

variable "dead_letter_identity" {
  description = "Dead letter identity configuration"
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

variable "storage_blob_dead_letter_destination" {
  description = "Storage blob dead letter destination"
  type = object({
    storage_account_id          = string
    storage_blob_container_name = string
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

