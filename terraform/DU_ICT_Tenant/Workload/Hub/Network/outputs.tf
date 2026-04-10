output "subnet_workload_id" {
  value = module.subnet_Workload1.subnet_id
}

output "subnet_bastion_id" {
  value = module.subnet_Bastion.subnet_id
}

output "virtual_network_id" {
  value = module.vnet.virtual_network_id
}

output "virtual_network_name" {
  value = module.vnet.virtual_network_name
}

output "bastion_id" {
  value = module.Bastion.Bastion_id
}
