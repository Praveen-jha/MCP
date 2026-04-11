variable "machine_learning_workspace_id" {
  description = "Resource ID of Machine Learning Workspace"
  type        = string
}

variable "subnet_resource_id" {
  description = "Resource ID of subnet"
  type        = string
}

variable "ml_compute_instance_name" {
  description = "Name of the Machine Learning compute instance"
  type        = string
}

variable "ml_compute_vm_size" {
  description = "Size of the VM for Machine Learning compute instance"
  type        = string
}

variable "ml_compute_tags" {
  description = "Tags for the Machine Learning compute instance"
  type        = map(string)
}

variable "node_public_ip_enabled" {
  description = "For public IP enabled or disabled"
  type        = bool
}

variable "object_id_user" {
  description = "Users AAD Object Id"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant id where user ID Exists"
  type = string
}
