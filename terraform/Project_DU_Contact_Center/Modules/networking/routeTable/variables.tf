variable "rt_name" {
  type    = string
  default = "Name of the route table"
}
 
variable "rt_location" {
  type        = string
  description = "The location (region) where the Azure Route Table will be created."
}
 
variable "rt_rg_name" {
  type        = string
  description = "The name of the Azure Resource Group where the Route Table will be created."
}
 
variable "rt_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}
 
variable "bgp_route_propagation_enabled" {
  type = bool
  description = "bgp route propagation status"
}
 
variable "rt_routes" {
  description = "List of routes for the Azure Route Table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
}
 