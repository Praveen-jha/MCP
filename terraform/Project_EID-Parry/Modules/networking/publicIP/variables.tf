#Name of Public IP Address
variable "pip_name" {
  type = string
  description = "Name of Public IP Address"
}

#Allocation method of PIP
variable "pip_allocation_method" {
  type = string
  description = "Allocation method of PIP"
}

#Name of pip resource group
variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

#Location of resource
variable "location" {
  type = string
  description = "Location of resource"
}

#SKU of PIP
variable "pip_sku" {
  type = string
  description = "SKU of PIP"
}

#Variable to define tags for public IP
variable "pip_tags" {
  type = map(string)
  description = "Tags for public IP"
}