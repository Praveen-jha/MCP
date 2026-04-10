variable "lng_name" {
  type = string
  description = "Name of HUB LNG"
}

variable "lng_location" {
  type = string
  description = "Location of HUB LNG"
}

variable "lng_resource_group_name" {
  type = string
  description = "Resource group name of HUB LNG"
}

variable "lng_address" {
  type = string
  description = "Address of HUB LNG"
}

variable "lng_address_space" {
  type = list(string)
  description = "Address space of HUB LNG"
}

# variable "lng_tags" {
#   type = map(string)
#   description = "Tags for local network gateway"
# }