output "compute_instance_id" {
  description = "The ID of the Machine Learning Compute Instance"
  value       = azurerm_machine_learning_compute_instance.ml_compute.id
}