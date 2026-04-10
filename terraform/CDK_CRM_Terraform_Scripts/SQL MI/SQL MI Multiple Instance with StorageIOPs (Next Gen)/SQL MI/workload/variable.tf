variable "location" {
  description = "The Azure region where the Azure Resources will be created."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = null
}

variable "name_config" {
  type = object({
    sql_mi_resource_group_creation          = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
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

# New variable for SQL Managed Instance configurations
variable "sql_mi_mapping" {
  description = "A map defining configurations for multiple SQL Managed Instances, including their private endpoint and DNS settings."
  type = map(object({
    name = string
    sql_mi_base = object({
      sql_mi_resource_type                = string //(Required) Specifies the resource type and API version in the format <resource-type>@<api-version>. Example: Microsoft.Sql/managedInstances@2021-05-01-preview.
      sql_mi_identity_type                = string //(Required) Specifies the type of managed identity to assign. Valid options include SystemAssigned, UserAssigned, or SystemAssigned,UserAssigned.
      sql_mi_admin_login                  = string //(Required) The administrator login name for the SQL Managed Instance. Changing this forces a new resource to be created.
      sql_mi_admin_password               = string //(Required) The administrator login name for the SQL Managed Instance. Changing this forces a new resource to be created.
      ad_group_display_name               = string //The friendly name of the Azure AD group that will be configured as the SQL MI administrator.
      ad_group_object_id                  = string //The unique Azure AD object ID of the administrator group or user that will manage the SQL Managed Instance.
      administrator_type                  = string //Defines the identity source for the administrator, typically ActiveDirectory, used for role-based access and authentication.)
      azuread_authentication_only_enabled = bool   //If set to true, only Azure Active Directory identities are allowed to authenticate to the SQL Managed Instance.
      azuread_principal_type              = string //Specifies the type of Azure AD entity (User, Group, or ServicePrincipal) to be assigned as administrator.
      tenant_id                           = string //The tenant ID of the Azure Active Directory associated with the SQL Managed Instance for identity and access management.
    })
    sql_mi_config = object({
      sql_mi_vcores                       = number //(Required) Specifies the number of vCores to allocate for the SQL Managed Instance. Allowed values depend on the selected hardware generation.
      sql_mi_storage_size                 = number //(Required) Specifies the size of storage (in GB) to allocate for the instance. Must be a multiple of 32.
      sql_mi_storage_iops                 = number //Storage IOps. Minimum value: 300. Maximum value: 80000. Increments of 1 IOps allowed only. Maximum value depends on the selected hardware family and number of vCores.
      sql_mi_timezone_id                  = string //(Optional) The timezone ID to configure the SQL Managed Instance with. Example: UTC.
      sql_mi_zone_redundant               = bool   //(Optional) Set to true to enable zone redundancy, which improves availability by deploying the instance across multiple availability zones.
      sql_mi_collation                    = string //(Optional) Defines the SQL Server collation to be used for the instance, controlling sorting and comparison behavior.
      sql_mi_database_format              = string //(Optional) Specifies the SQL database format version for compatibility with SQL Server engine features.
      sql_mi_is_general_purpose_v2        = bool   //(Optional) Indicates whether to deploy the SQL Managed Instance using the General Purpose v2 tier.
      sql_mi_license_type                 = string //(Optional) Specifies the license type. Valid values are 'LicenseIncluded' and 'BasePrice'.
      sql_mi_minimal_tls_version          = string //(Optional) Minimum supported TLS version for the SQL Managed Instance. Allowed values: 1.0, 1.1, 1.2.
      sql_mi_pricing_model                = string //(Optional) Specifies the pricing model used for billing. Example: vCore.
      sql_mi_proxy_override               = string //(Optional) Controls the proxy behavior for the SQL Managed Instance. Valid values are 'Default', 'Proxy', and 'Redirect'.
      sql_mi_public_data_endpoint_enabled = bool   //(Optional) Set to true to enable the public endpoint for data access on the SQL Managed Instance.
      sql_mi_backup_storage_redundancy    = string //(Optional) Specifies the redundancy option for backup storage. Valid values include LRS, ZRS, GRS, and GZRS.
    })
    sku = object({
      sql_mi_sku_capacity = number //(Required) Specifies the capacity of the SKU in terms of compute resources.
      sql_mi_sku_family   = string //(Required) Specifies the hardware generation (e.g., Gen4, Gen5) for the SQL Managed Instance.
      sql_mi_sku_name     = string //(Required) Specifies the SKU name of the SQL Managed Instance. Valid values: GP_Gen4, GP_Gen5, GP_Gen8IM, GP_Gen8IH, BC_Gen4, BC_Gen5, BC_Gen8IM, BC_Gen8IH.
      sql_mi_sku_tier     = string //(Required) Specifies the service tier for the SQL Managed Instance. Valid values are 'GeneralPurpose' or 'BusinessCritical'.
    })
  }))
}

variable "existing_resource_group_sql_mi_name" {
  type        = string
  description = "Name of the Existing Resource Group in which SQL Managed Instance is to be created."
}

variable "existing_pep_same_vnet_resource_group_name" {
  type        = string
  description = "Name of the resource group containing the subnet and VNet for the private endpoint."
}

variable "existing_pep_same_vnet_virtual_network_name" {
  description = "Name of the virtual network for the private endpoint in the same VNet"
  type        = string
}

variable "existing_pep_same_vnet_subnet_name" {
  type        = string
  description = "Name of the subnet for the private endpoint in the same VNet"
}

variable "existing_sqlmi_subnet_name" {
  description = "Name of the existing subnet used for SQL MI"
  type        = string
}

variable "existing_pep_diff_vnet_resource_group_name" {
  type        = string
  description = "Name of the resource group containing the the different VNet."
}

variable "existing_pep_diff_vnet_virtual_network_name" {
  description = "Name of the virtual network for the private endpoint in the Different VNet"
  type        = string
}

variable "existing_pep_diff_vnet_subnet_name" {
  type        = string
  description = "Name of the subnet for the private endpoint in the Different VNet"
}

variable "public_network_access_enabled" {
  description = "Is Public Network Access enabled for the Windows Web App."
  type        = bool
}

variable "private_endpoint_same_vnet" {
  description = "Boolean flag to determine if the private endpoint is in the same VNet as the resource"
  type        = bool
}

variable "private_dns_zone_name_same_vnet" {
  description = "Private DNS Zone name to use when the private endpoint is in the same VNet"
  type        = string
}

variable "private_endpoint_diff_vnet" {
  description = "Boolean flag to determine if the private endpoint is in a different VNet"
  type        = bool
}

variable "private_dns_zone_name_diff_vnet" {
  description = "Private DNS Zone name to use when the private endpoint is in a different VNet"
  type        = string
}

variable "private_dns_zone_resource_group_name" {
  description = "The name of the Resource Group where the Azure Private DNS Zone is located."
  type        = string
}
