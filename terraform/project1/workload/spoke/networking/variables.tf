variable "networking" {
  type = object({
    spoke_rg_name        = string
    spoke_vnet_name      = string
    dbx_host_subnet      = string
    dbx_container_subnet = string
    spoke_pep_subnet     = string
    spoke_compute_subnet = string
  })
}

# //Virtual Machines Objects - The attributes of this object will be used to define the virtual_machine map in the locals block in local.tf file
variable "self_hosted_integration_runtime_vm" {
  description = "Details of Self Hosted Integration Runtime Virtual Machine"
  type = object({
    vm_name           = string //Name of the Self Hosted Integration Runtime Virtual Machine
    vm_size           = string //Size of the Self Hosted Integration Runtime Virtual Machine
    availability_zone = string //Availability Zone of the Self Hosted Integration Runtime Virtual Machine
    admin_username    = string // username for virtual machine
  })
}
variable "self_hosted_integration_runtime_vm_2" {
  description = "Details of Self Hosted Integration Runtime Virtual Machine"
  type = object({
    vm_name           = string //Name of the Self Hosted Integration Runtime Virtual Machine
    vm_size           = string //Size of the Self Hosted Integration Runtime Virtual Machine
    availability_zone = string //Availability Zone of the Self Hosted Integration Runtime Virtual Machine
    admin_username    = string // username for virtual machine
  })
}
variable "on_premises_data_gateway_vm" {
  description = "Details of On Premises Data Gateway Virtual Machine"
  type = object({
    vm_name           = string //Name of the On-Premises Data Gateway Virtual Machine
    vm_size           = string //Size of the On-Premises Data Gateway Virtual Machine
    availability_zone = string //Availability Zone of the On-Premises Data Gateway Virtual Machine Allowed Values are "null", "1", "2" and "3"
    admin_username    = string // username for virtual machine
  })
}
variable "on_premises_data_gateway_vm_2" {
  description = "Details of On Premises Data Gateway Virtual Machine"
  type = object({
    vm_name           = string //Name of the On-Premises Data Gateway Virtual Machine
    vm_size           = string //Size of the On-Premises Data Gateway Virtual Machine
    availability_zone = string //Availability Zone of the On-Premises Data Gateway Virtual Machine Allowed Values are "null", "1", "2" and "3"
    admin_username    = string // username for virtual machine
  })
}

variable "common_tags" {
  type = map(string)
  description = "tags for the resources"
}
variable "source_image_id" {
  type = string
  description = "Custom Image ID for virtual machine"
}
