# Create EventGrid System Topic
resource "azurerm_eventgrid_system_topic" "this" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  source_arm_resource_id = var.source_arm_resource_id
  topic_type             = var.topic_type

  # Optional parameters
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = var.tags
}
