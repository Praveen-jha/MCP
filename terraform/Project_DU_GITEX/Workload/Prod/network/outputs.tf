output "vnet_id" {
  value = module.vnet.virtual_network_id
}

output "pep_subnet_id" {
  value = module.subnet_pep.subnet_id
}

output "subnet_compute_id" {
  value = module.subnet_compute.subnet_id
}

output "subnet_python_app_service_id" {
  value = module.subnet_python_app_service.subnet_id
}

output "subnet_node_app_service_id" {
  value = module.subnet_node_app_service.subnet_id
}