variable "name_config" {
  type = object({
    data_factory_resource_group_creation    = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_resource_group_creation = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation                = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation                         = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    data_factory_creation                  = string //"Flag to indicate whether a new Data Factory should be created or existing Data Factory is used."
    environment                             = string //Deployment Environment (for example UAT or Prod).
    short_name                              = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name                            = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag                             = string //Central US (cus), East US 2 (eus2)
    instance                                = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application                             = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
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

variable "existing_target_resources" {
  description = "Map of existing target resources for managed private endpoints"
  type = map(object({
    type               = string # "storage_account", "key_vault", "sql_server"
    name               = string # Name of the existing resource
    resource_group     = string # Resource group where the existing resource is located
    subresource_name   = string # "blob", "file", "vault", "sqlServer", etc.
  }))
}


variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
variable "data_factory_name" {
  description = "Name of the Data Factory instance"
  type        = string
  default     = ""
  
}