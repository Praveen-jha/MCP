variable "evenhub_namespace_name" {
  description = "(Required) Specifies the name of the eventhub namespace"
  type        = string
}
variable "eventhub_namespace_location" {
  description = "(Required) Specifies the location of the Eventhub Namespace"
  type        = string
}
variable "evenhub_namespace_rg" {
  description = "(Required) Specifies the Resource Group of the Eventhub Namespace"
  type        = string
}
variable "evenhub_namespace_sku" {
  description = "(Required) Specifies the SKU of the Eventhub Namespace"
  type        = string
}
variable "eventhub_namespace_capacity" {
  description = "(Optional) Specifies the SKU of the Eventhub Namespace"
  type        = number
  default     = 1
}
variable "local_authentication_enabled" {
  description = "(Optional) Specifies if local authentication is enabled Eventhub Namespace"
  type        = bool
  default     = true
}
variable "eventhub_namespace_public_network_access_enabled" {
  description = "(Required) Specifies the public access of the Eventhub Namespace"
  type        = bool
}
variable "eventhub_namespace_auto_inflate_enabled" {
  description = "is Auto Inflate enabled for the EventHub Namespace"
  type        = bool
}
variable "eventhub_namespace_max_throughput_units" {
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
  type        = number
}
variable "evenhub_namespace_identity_type" {
  description = "identity type for the eventhub namespace"
  type        = string
  default     = "SystemAssigned"
}
variable "tags" {
  description = "Tags for eventhub"
  type        = map(string)
}
