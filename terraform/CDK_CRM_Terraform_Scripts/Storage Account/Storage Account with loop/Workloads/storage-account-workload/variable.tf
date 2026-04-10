# Variables for creating a new resource group for the storage account
variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = null
}

variable "name_config" {
  type = object({
    storage_account_resource_group_creation = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
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

variable "storage_account_mapping" {
  description = "A map of storage account configurations, where each key is a unique identifier and the value is an object containing storage account details."
  type = map(object({
    name = optional(string) //Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. This must be unique across the entire Azure service, not just within the resource group.
    storage_account = object({
      account_tier             = string //Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created.
      account_replication_type = string //Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
      account_kind             = string //Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
      is_hns_enabled           = bool   //Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created.
    })
  }))
}

# Declaring variables for existing resources
variable "existing_resource_group_storage_account_name" {
  description = "Name of the existing resource group where the storage account will deploy."
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
  description = "The name of the existing Subnet to reference for private endpoint."
  type        = string
}

variable "new_storage_account_resource_group_name" {
  description = "The name of the new resource group to be created for the storage account."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether the public network access is enabled? Defaults to true."
  type        = bool
}

variable "enable_private_dns_zone_group" {
  description = "Whether to enable the private DNS zone group."
  type        = bool
  default     = false
}

variable "storage_account_private_dns_zone_ids" {
  description = "A list of private DNS zone IDs."
  type        = list(string)
  default     = null
}
