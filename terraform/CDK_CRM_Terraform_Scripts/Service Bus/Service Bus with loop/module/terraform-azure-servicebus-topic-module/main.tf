
# Module: terraform-azure-servicebus-topic
# Resource: azurerm_servicebus_topic
# Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic

resource "azurerm_servicebus_topic" "this" {
  name                                    = var.name
  namespace_id                            = var.namespace_id
  status                                  = var.status
  auto_delete_on_idle                     = var.auto_delete_on_idle
  default_message_ttl                     = var.default_message_ttl
  duplicate_detection_history_time_window = var.duplicate_detection_history_time_window
  batched_operations_enabled              = var.batched_operations_enabled
  express_enabled                         = var.express_enabled
  partitioning_enabled                    = var.partitioning_enabled
  max_message_size_in_kilobytes           = var.max_message_size_in_kilobytes
  max_size_in_megabytes                   = var.max_size_in_megabytes
  requires_duplicate_detection            = var.requires_duplicate_detection
  support_ordering                        = var.support_ordering
}
 
