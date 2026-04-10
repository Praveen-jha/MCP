variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the Function App will be created."
  
}
variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}
variable "tags" {
  type        = map(string)
  description = "Tags for the resource group."
  
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Account replication type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, or RAGZRS."
  }
}

# Variables for optional parameters
variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."
  type        = string

  validation {
    condition     = var.account_kind == null || contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "Account kind must be one of: BlobStorage, BlockBlobStorage, FileStorage, Storage, or StorageV2."
  }
}

variable "os_type" {
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values are Windows, Linux, and WindowsContainer."
  type        = string
  validation {
    condition     = contains(["Windows", "Linux", "WindowsContainer"],var.os_type)
    error_message = "The os_type must be one of 'Windows', 'Linux', or 'WindowsContainer'."
  }
}

variable "sku_name" {
  description = "(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I1mv2, I2v2, I2mv2, I3v2, I3mv2, I4v2, I4mv2, I5v2, I5mv2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1."
  type        = string
  validation {
    condition = contains([
      "B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I1mv2", "I2v2", "I2mv2",
      "I3v2", "I3mv2", "I4v2", "I4mv2", "I5v2", "I5mv2", "I6v2", "P1v2", "P2v2", "P3v2",
      "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3",
      "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "FC1", "WS1", "WS2", "WS3", "Y1"
    ], var.sku_name)
    error_message = "The sku_name must be one of the supported Azure App Service Plan SKUs."
  }
}



variable "name_config" {
  type = object({
    resource_group_creation  = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation          = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    environment              = string //Deployment Environment (for example UAT or Prod).
    short_name               = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name             = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag              = string //Central US (cus), East US 2 (eus2)
    instance                 = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application              = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}

variable "public_network_access_enabled" {
  description = "Flag to enable or disable public network access for the Function App."
  type        = bool
  default     = true

  validation {
    condition     = can(var.public_network_access_enabled)
    error_message = "public_network_access_enabled must be a boolean value."
  }
  
}
variable "enable_private_dns_zone_group" {
  description = "Whether to enable the private DNS zone group."
  type        = bool
}

variable "private_dns_zone_id" {
  description = "A list of private DNS zone IDs for Web App."
  type        = list(string)
  default     = null
}

variable "web_app_vnet_integration_enable" {
  type        = bool
  description = "To determine whether VNet integration is enabled for Web Apps. If false, virtual_network_subnet_id will be null."
}

variable "existing_resource_group_name" {
  type        = string
  description = "Name of the Existing Resource Group"
}

variable "existing_virtual_network_name" {
  type        = string
  description = "Name of the Existing Virtual Network"
}

variable "existing_private_endpoint_subnet_name" {
  type        = string
  description = "Name of the Existing Inbound Subnet for App Service"
}

variable "existing_outbound_subnet_name" {
  type        = string
  description = "Name of the Existing Outbound Subnet for App Service"
}