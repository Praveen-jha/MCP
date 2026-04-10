variable "data_factory_name" {
  description = "(Required) Specifies the name of the Data Factory"
  type        = string
}

variable "ssis_integration_runtime_name" {
  type        = string
  description = "value"
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

variable "identity_type" {
  description = "The type of identity to use for the SSIS Integration Runtime. Possible values are 'SystemAssigned' or 'UserAssigned'."
  type        = string
}

variable "node_size" {
  description = "The size of the nodes in the SSIS Integration Runtime."
  type        = string
}

variable "number_of_nodes" {
  description = "The number of nodes in the SSIS Integration Runtime."
  type        = number
}

variable "catalog_info" {
  description = "A catalog_info block for the SSIS Integration Runtime"
  type = object({
    server_endpoint        = string
    administrator_login    = optional(string)
    administrator_password = optional(string)
    pricing_tier           = optional(string)
    dual_standby_pair_name = optional(string)
    elastic_pool_name      = optional(string)
  })
}

variable "license_type" {
  description = "The type of the license that is used. Valid values: LicenseIncluded, BasePrice"
  type        = string
  default     = "LicenseIncluded"
  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "license_type must be LicenseIncluded or BasePrice."
  }
}

variable "enable_vnet_integration" {
  type        = bool
  description = "Variable to determise, Vnet Integration in enabled in SSIS IR or not."
}

variable "data_factory_credential_umi_name" {
  type        = string
  description = "The name of the Data Factory Credential for User Managed Identity."
}

variable "existing_data_factory_rg_name" {
  type        = string
  description = "Name of the Existing Resource Group for Azure Data Factory."
}

variable "existing_vnet_rg_name" {
  type        = string
  description = "Name of the Existing Resource Group for Virtual Network."
}

variable "existing_virtual_network_name" {
  type        = string
  description = "Name of the Existing Virtual Network"
}

variable "existing_private_ssis_subnet_name" {
  type        = string
  description = "Name of the Existing Inbound Subnet for SSIS IR"
}

variable "existing_user_assigned_identity_name" {
  type        = string
  description = "Name of the Existing User Assigned Identity."
}

variable "existing_user_assigned_identity_rg_name" {
  type        = string
  description = "Name of the Resource Group in which User Assigned Identity Exists."
}
