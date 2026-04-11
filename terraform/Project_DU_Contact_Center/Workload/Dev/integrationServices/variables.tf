# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}


# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}


# #Variable to define Fabric Capacity name
# variable "fabric_capacity_sku_name" {
#   description = "Name of Fabric Capacity SKU name"
#   type = string
# }
# #Variable to define SKU of Fabric Capacity
# variable "fabric_capacity_sku" {
#   description = "Fabric Capacity SKU"
#   type        = string
# }

# #Variable to define administrator of fabric capacity
# variable "fabric_capacity_admin" {
#   description = "Administrator of fabric capacity"
#   type        = string
# }

# #Variable to define tags for fabric capacity
# variable "tags" {
#   description = "Tags for fabric capacity"
#   type        = map(string)
# }


 
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

# variable "resource_group_tags" {
#   description = "resource group tags"
#   type        = map(string)
# }

variable "location_shortname" {
  description = "Location shortname"
  type        = string
}

variable "workload_type" {
  description = "workload type of the resource"
  type        = string
}