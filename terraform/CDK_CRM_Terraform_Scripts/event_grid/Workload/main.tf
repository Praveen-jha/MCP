#creation of event grid system topic
module "eventGridSystemTopicName" {
  source = "../Modules/terraform-azure-event-grid-system-topic-module"

  name                   = local.event_grid_system_topic_name
  resource_group_name    = data.azurerm_resource_group.existing_resource_group[0].name
  location               = data.azurerm_resource_group.existing_resource_group[0].location
  source_arm_resource_id = module.StorageAccounts.storage_account_id
  topic_type             = var.topic_type
  tags                   = var.tags

  depends_on = [module.StorageAccounts]
}

# EventGrid System Topic Event Subscriptions
module "system_topic_event_subscription" {
  source = "../Modules/terraform-azure-event-grid-system-topic-event-subscription-module"

  name                = local.eventgrid_subscriptions_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group[0].name
  system_topic        = module.eventGridSystemTopicName.name

  # Endpoint configuration (only one should be specified)
  storage_queue_endpoint = var.endpoint_type == "storage_queue" ? {
    queue_name         = module.storage_queue.name
    storage_account_id = module.StorageAccounts.storage_account_id
  } : null

  azure_function_endpoint = var.endpoint_type == "azure_function" && var.azure_function_endpoint != null ? {
    function_id                       = data.azurerm_function_app.existing_function_app[0].id
    max_events_per_batch              = var.azure_function_endpoint.max_events_per_batch
    preferred_batch_size_in_kilobytes = var.azure_function_endpoint.preferred_batch_size_in_kilobytes
  } : null

  webhook_endpoint = var.endpoint_type == "webhook" && var.webhook_endpoint != null ? var.webhook_endpoint : null

  # Filtering configuration (will be null if not specified)
  subject_filter                       = var.subject_filter
  advanced_filters                     = var.advanced_filters
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled

  # Additional configuration (will be null if not specified)
  # Only set event_delivery_schema if it's not null
  event_delivery_schema = var.event_delivery_schema != null ? var.event_delivery_schema : "EventGridSchema"
  included_event_types  = var.included_event_types
  labels                = var.labels
  expiration_time       = var.expiration_time

  # Retry and identity policies (will be null if not specified)
  retry_policy                         = var.retry_policy
  delivery_identity                    = var.delivery_identity
  dead_letter_identity                 = var.dead_letter_identity
  storage_blob_dead_letter_destination = var.storage_blob_dead_letter_destination

  depends_on = [
    module.eventGridSystemTopicName,
    module.StorageAccounts,
    module.storage_queue
  ]
}

