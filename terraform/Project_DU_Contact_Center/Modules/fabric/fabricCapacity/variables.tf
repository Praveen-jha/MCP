#Variable to define fabric capacity name
variable "fabric_capacity_name" {
  description = "Name of the fabrci capacity"
  type        = string
}
 
#Variable to define Fabric capacity location
variable "fabric_location" {
  description = "Location of the Fabric capacity"
  type        = string
}

#Variable to define name of Fabric Capacity SKU
variable "fabric_capacity_sku_name" {
  description = "Name of Fabric Capacity SKU"
  type = string
}
#Variable to define SKU of Fabric Capacity
variable "fabric_capacity_sku" {
  description = "Fabric Capacity SKU name"
  type        = string
}

#Variable to define tier of Fabric Capacity
variable "fabric_capacity_tier" {
  description = "Fabric Capacity tier name"
  type        = string
}

#Variable to define parent ID of Fabric capacity
variable "resource_group_id" {
  description = "Parent ID of Fabric capacity"
  type = string
}

#Variable to define administrator of fabric capacity
variable "fabric_capacity_admin" {
  description = "Administrator of fabric capacity"
  type = string
}

#Variable to define tags for Fabric Capacity
variable "fabric_tags" {
  description = "Tags for Fabric Capacity"
  type = map(string)
}

#Variable to define resource group for Fabric Capacity
variable "fabric_cap_rg_name" {
  description = "Resource Group for Fabric Capacity"
  type = string
}

