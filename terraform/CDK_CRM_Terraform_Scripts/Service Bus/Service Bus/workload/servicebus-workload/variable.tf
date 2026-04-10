variable "location" {
  description = "Azure region where the resource will be deployed."
  type        = string
}

variable "new_servicebus_resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the servicebus should exist."
}

variable "name_config" {
  type = object({
    servicebus_resource_group_creation      = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_resource_group_creation = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation                = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation                         = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    environment                             = string //Deployment Environment (for example UAT or Prod).
    short_name                              = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name                            = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag                             = string //Central US (cus), East US 2 (eus2)
    instance                                = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application                             = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}

variable "servicebus_config" {
  type = object({
    sku                          = string //(Required) SKU for the Service Bus Namespace (Basic, Standard, Premium)
    capacity                     = number //(Required) Messaging units for Premium SKU or partition count for Standard. capacity >= 0 && capacity <= 16
    premium_messaging_partitions = number //(Required) Number of messaging partitions for Premium SKU. If provided, premium_messaging_partitions must be between 1 and 4.
    local_auth_enabled           = bool   //(optional) Whether local authentication is enabled.
    minimum_tls_version          = string // (required)  The minimum TLS version to support. minimum_tls_version must be one of: 1.0, 1.1, 1.2
  })
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the Service Bus Namespace."
  type        = map(string)
  default     = {}
}

variable "enable_private_dns_zone_group" {
  description = "Whether to enable the private DNS zone group."
  type        = bool
}

variable "service_bus_private_dns_zone_id" {
  description = "A list of private DNS zone IDs for Service Bus."
  type        = list(string)
  default     = null
}

#Declaring variables for existing resources
variable "existing_resource_group_servicebus_name" {
  description = "Name of the existing resource group where the service bus will deploy."
  type        = string
}
variable "existing_resource_group_virtual_network_name" {
  description = "Name of the existing resource group where the virtual network and subnet are located."
  type        = string
}
variable "existing_virtual_network_name" {
  description = "The name of the existing Virtual Network to reference when 'virtual_network_creation' is set to 'existing'."
  type        = string
}

variable "existing_private_endpoint_subnet_name" {
  description = "The name of the existing Subnet to reference when 'subnet_creation' is set to 'existing'."
  type        = string
}
