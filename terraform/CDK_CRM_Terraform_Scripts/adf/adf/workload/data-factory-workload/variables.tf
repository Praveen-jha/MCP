variable "data_factory_name" {
  description = "(Required) Specifies the name of the Data Factory"
  type        = string
}

variable "location" {
  description = "The Azure region where the Azure Resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Azure Resources."
  type        = map(string)
  default     = {}
}

variable "name_config" {
  type = object({
    data_factory_resource_group_creation    = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
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

variable "new_data_factory_resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the redis cache should exist."
}

variable "public_network_access_enabled" {
  description = "Is Public Network Access enabled for the Windows Web App."
  type        = bool
}

variable "managed_virtual_network_enabled" {
  description = "Specifies whether the Managed Virtual Network feature is enabled for the Azure Data Factory. Setting this to 'true' enables secure network traffic between data sources."
  type        = bool
  default     = null
}

variable "identity_type" {
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this Data Factory. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  type        = string
}

variable "existing_resource_group_data_factory_name" {
  type        = string
  description = "Name of the Existing Resource Group for Azure Data Factory."
}

variable "existing_resource_group_virtual_network_name" {
  type        = string
  description = "Name of the Existing Resource Group for Virtual Network."
}

variable "existing_virtual_network_name" {
  type        = string
  description = "Name of the Existing Virtual Network"
}

variable "existing_private_endpoint_subnet_name" {
  type        = string
  description = "Name of the Existing Inbound Subnet for App Service"
}

variable "enable_private_dns_zone_group" {
  description = "Whether to enable the private DNS zone group."
  type        = bool
}

variable "data_factory_private_dns_zone_id" {
  description = "A list of private DNS zone IDs for Web App."
  type        = list(string)
  default     = null
}
