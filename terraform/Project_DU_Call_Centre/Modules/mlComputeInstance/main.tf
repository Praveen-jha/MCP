resource "azurerm_machine_learning_compute_instance" "ml_compute" {
  name                          = var.ml_compute_instance_name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  virtual_machine_size          = var.ml_compute_vm_size
  subnet_resource_id            = var.subnet_resource_id
  node_public_ip_enabled        = var.node_public_ip_enabled
  tags                          = var.ml_compute_tags

  assign_to_user {
    object_id = var.object_id_user
    tenant_id = var.tenant_id
  }
}