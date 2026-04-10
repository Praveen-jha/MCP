# This file is part of a Terraform module for managing Azure Storage Queues.
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue
resource "azurerm_storage_queue" "this" {
  name                 = var.name
  storage_account_name = var.storage_account_name

  # Optional parameters
  metadata = var.metadata

  # Dynamic timeouts block
  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}