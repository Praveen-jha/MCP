variable "nic_name" {
  type        = string
  description = "name of the NIC"
}
variable "tags" {
  type        = map(string)
  description = "tags for the resources"
}
variable "subnet_id" {
  type        = string
  description = "Id of the subnet where resource will be created"
}
variable "nic_ip_config_name" {
  type        = string
  description = "name of the ip configuration"
}
variable "private_ip_address_allocation" {
  type        = string
  description = "ip allocation type for the private ip address"
}
variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}
variable "vm_resource_group" {
  type        = string
  description = "resource group of the virtual machine"
}
variable "vm_location" {
  type        = string
  description = "location of the virutal machine"
}
variable "vm_size" {
  type        = string
  description = "size of the virtual machine"
}
variable "vm_zone" {
  type        = string
  description = "zone in which vm will be deployed"
}
variable "admin_username" {
  type        = string
  description = "username for the virtual machine"
}
variable "admin_password" {
  type        = string
  description = "password for the admin user"
}
variable "identity" {
  type    = string
  default = "SystemAssigned"
}
variable "os_disk_name" {
  type        = string
  description = "value"
}
variable "os_disk_storage_account_type" {
  type        = string
  description = "storage account type for managed disk"
}
variable "os_disk_caching" {
  type        = string
  description = "value"
}
variable "os_disk_disk_size_gb" {
  type        = string
  description = "size of the disk in GB"
}
variable "source_image_id" {
  type        = string
  description = "Id of source image"
}



