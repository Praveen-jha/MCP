output "aks_name" {
  description = "The name of the Kubernetes Cluster"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.name
}
output "aks_id" {
  description = "The ID of the Kubernetes Cluster"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.id
}
output "aks" {
  description = "The ID of the Kubernetes Cluster"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster
}
