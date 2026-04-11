variable "fabric_cap_name" {
  description = "The name which should be used for the Fabric Capacity. Changing this forces a new resource to be created."
  type        = string
}
variable "fabric_cap_rg_name" {
  description = "The name of the Resource Group in which to create the Fabric Capacity. Changing this forces a new resource to be created."
  type        = string
}
variable "fabric_cap_location" {
  description = "The supported Azure location where the Fabric Capacity exists. Changing this forces a new resource to be created."
  type        = string
}
variable "fabric_cap_administration_members" {
  description = "An array of administrator user identities. The member must be an Entra member user or a service principal"
  type        = list(string)
}
variable "fabric_cap_sku" {
  description = "The name of the SKU to use for the Fabric Capacity. Possible values are F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048"
  type        = string
}
variable "fabric_cap_tags" {
  description = "Tags for Fabric Capacity"
  type        = map(string)
}