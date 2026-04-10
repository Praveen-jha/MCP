# variable.tf
# This variable file defines configuration options for provisioning Azure Storage Accounts using Terraform.

variable "storage_account_name" {
  description = "Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. This must be unique across the entire Azure service, not just within the resource group."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be between 3 and 24 characters long and can only contain lowercase letters and numbers."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._\\-]{1,90}$", var.resource_group_name)) && !can(regex("\\.$", var.resource_group_name))
    error_message = "Resource group name must be 1-90 characters long, can contain alphanumeric characters, periods, underscores, hyphens, and cannot end with a period."
  }
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition = contains([
      "eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast",
      "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope",
      "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast",
      "koreacentral", "canadacentral", "francecentral", "germanywestcentral",
      "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "qatarcentral",
      "australiacentral", "australiacentral2", "australiasoutheast", "japanwest",
      "koreasouth", "southindia", "westindia", "canadaeast", "francesouth",
      "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral",
      "southafricawest", "westus", "northcentralus"
    ], var.location)
    error_message = "Location must be a valid Azure region."
  }
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

variable "cross_tenant_replication_enabled" {
  description = "Should cross Tenant replication be enabled? Defaults to false."
  type        = bool
  default     = null
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot, Cool, Cold and Premium. Defaults to Hot."
  type        = string
  default     = "Hot"
  validation {
    condition     = var.access_tier == null || contains(["Hot", "Cool", "Cold", "Premium"], var.access_tier)
    error_message = "Access tier must be one of: Hot, Cool, Cold, or Premium."
  }
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  type        = string
  default     = null
}

variable "https_traffic_only_enabled" {
  description = "Boolean flag which forces HTTPS if enabled. Defaults to true."
  type        = bool
  default     = null
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  type        = string
  default     = "TLS1_2"
  validation {
    condition     = var.min_tls_version == null || contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "Minimum TLS version must be one of: TLS1_0, TLS1_1, or TLS1_2."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
  type        = bool
  default     = null
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). Defaults to true."
  type        = bool
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether the public network access is enabled? Defaults to true."
  type        = bool
  default     = null
}

variable "default_to_oauth_authentication" {
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false."
  type        = bool
  default     = null
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created."
  type        = bool
  default     = null
}

variable "nfsv3_enabled" {
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false."
  type        = bool
  default     = null
}

variable "large_file_share_enabled" {
  description = "Are Large File Shares Enabled? Defaults to false."
  type        = bool
  default     = null
}

variable "local_user_enabled" {
  description = "Is Local User Enabled? Defaults to true."
  type        = bool
  default     = null
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
  type        = bool
  default     = null
}

variable "allowed_copy_scope" {
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink."
  type        = string
  default     = null
}

variable "sftp_enabled" {
  description = "Boolean, enable SFTP for the storage account. SFTP support requires is_hns_enabled set to true. Defaults to false."
  type        = bool
  default     = null
}

variable "dns_endpoint_type" {
  description = "Specifies which DNS endpoint type to use. Possible values are Standard and AzureDnsZone. Defaults to Standard. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# Complex optional block variables
variable "custom_domain" {
  description = "A custom_domain block - The Custom Domain Name to use for the Storage Account, which will be validated by Azure."
  type = object({
    name          = string         # The Custom Domain Name to use for the Storage Account, which will be validated by Azure
    use_subdomain = optional(bool) # Should the Custom Domain Name be validated by using indirect CNAME validation?
  })
  default = null
}

variable "customer_managed_key" {
  description = "A customer_managed_key block - Customer managed key configuration for the storage account."
  type = object({
    key_vault_key_id          = optional(string) # The ID of the Key Vault Key, supplying a version-less key ID will enable auto-rotation of this key
    managed_hsm_key_id        = optional(string) # The ID of the managed HSM Key. Exactly one of key_vault_key_id and managed_hsm_key_id may be specified
    user_assigned_identity_id = string           # The ID of a user assigned identity
  })
  default = null
}

variable "identity" {
  description = "An identity block - Specifies the type of Managed Service Identity that should be configured on this Storage Account."
  type = object({
    type         = string                 # Specifies the type of Managed Service Identity. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned
    identity_ids = optional(list(string)) # Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account
  })
  default = null
}

variable "blob_properties" {
  description = "A blob_properties block - Blob service properties for the storage account."
  type = object({
    cors_rule = optional(list(object({  # A cors_rule block - Cross-Origin Resource Sharing rules
      allowed_headers    = list(string) # A list of headers that are allowed to be a part of the cross-origin request
      allowed_methods    = list(string) # A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH
      allowed_origins    = list(string) # A list of origin domains that will be allowed by CORS
      exposed_headers    = list(string) # A list of response headers that are exposed to CORS clients
      max_age_in_seconds = number       # The number of seconds the client should cache a preflight response
    })))
    delete_retention_policy = optional(object({   # A delete_retention_policy block
      days                     = optional(number) # Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7
      permanent_delete_enabled = optional(bool)   # Indicates whether permanent deletion of the soft deleted blob versions and snapshots is allowed. Defaults to false
    }))
    restore_policy = optional(object({ # A restore_policy block - Must be used together with delete_retention_policy set, versioning_enabled and change_feed_enabled set to true
      days = number                    # Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy
    }))
    versioning_enabled            = optional(bool)        # Is versioning enabled? Default to false
    change_feed_enabled           = optional(bool)        # Is the blob service properties for change feed events enabled? Default to false
    change_feed_retention_in_days = optional(number)      # The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years)
    default_service_version       = optional(string)      # The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version
    last_access_time_enabled      = optional(bool)        # Is the last access time based tracking enabled? Default to false
    container_delete_retention_policy = optional(object({ # A container_delete_retention_policy block
      days = optional(number)                             # Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7
    }))
  })
  default = null
}

variable "queue_properties" {
  description = "A queue_properties block - Queue service properties for the storage account."
  type = object({
    cors_rule = optional(list(object({  # A cors_rule block - Cross-Origin Resource Sharing rules
      allowed_headers    = list(string) # A list of headers that are allowed to be a part of the cross-origin request
      allowed_methods    = list(string) # A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH
      allowed_origins    = list(string) # A list of origin domains that will be allowed by CORS
      exposed_headers    = list(string) # A list of response headers that are exposed to CORS clients
      max_age_in_seconds = number       # The number of seconds the client should cache a preflight response
    })))
    logging = optional(object({                # A logging block
      delete                = bool             # Indicates whether all delete requests should be logged
      read                  = bool             # Indicates whether all read requests should be logged
      version               = string           # The version of storage analytics to configure
      write                 = bool             # Indicates whether all write requests should be logged
      retention_policy_days = optional(number) # Specifies the number of days that logs will be retained
    }))
    minute_metrics = optional(object({         # A minute_metrics block
      enabled               = bool             # Indicates whether minute metrics are enabled for the Queue service
      version               = string           # The version of storage analytics to configure
      include_apis          = optional(bool)   # Indicates whether metrics should generate summary statistics for called API operations
      retention_policy_days = optional(number) # Specifies the number of days that logs will be retained
    }))
    hour_metrics = optional(object({           # A hour_metrics block
      enabled               = bool             # Indicates whether hour metrics are enabled for the Queue service
      version               = string           # The version of storage analytics to configure
      include_apis          = optional(bool)   # Indicates whether metrics should generate summary statistics for called API operations
      retention_policy_days = optional(number) # Specifies the number of days that logs will be retained
    }))
  })
  default = null
}

variable "static_website" {
  description = "A static_website block - Static website configuration."
  type = object({
    index_document     = optional(string) # The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive
    error_404_document = optional(string) # The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file
  })
  default = null
}

variable "share_properties" {
  description = "A share_properties block - File share properties for the storage account."
  type = object({
    cors_rule = optional(list(object({  # A cors_rule block - Cross-Origin Resource Sharing rules
      allowed_headers    = list(string) # A list of headers that are allowed to be a part of the cross-origin request
      allowed_methods    = list(string) # A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH
      allowed_origins    = list(string) # A list of origin domains that will be allowed by CORS
      exposed_headers    = list(string) # A list of response headers that are exposed to CORS clients
      max_age_in_seconds = number       # The number of seconds the client should cache a preflight response
    })))
    retention_policy = optional(object({ # A retention_policy block
      days = optional(number)            # Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7
    }))
    smb = optional(object({                                   # A smb block - SMB protocol settings
      versions                        = optional(set(string)) # A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1
      authentication_types            = optional(set(string)) # A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos
      kerberos_ticket_encryption_type = optional(set(string)) # A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256
      channel_encryption_type         = optional(set(string)) # A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM
      multichannel_enabled            = optional(bool)        # Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts
    }))
  })
  default = null
}

variable "network_rules" {
  description = "A network_rules block - Network access rules for the storage account."
  type = object({
    default_action             = string                 # Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow
    bypass                     = optional(set(string))  # Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None
    ip_rules                   = optional(list(string)) # List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. /31 CIDRs, /32 CIDRs, and Private IP address ranges are not allowed
    virtual_network_subnet_ids = optional(list(string)) # A list of resource ids for subnets
    private_link_access = optional(list(object({        # One or more private_link_access block
      endpoint_resource_id = string                     # The ID of the Azure resource that should be allowed access to the target storage account
      endpoint_tenant_id   = optional(string)           # The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id
    })))
  })
  default = null
}

variable "azure_files_authentication" {
  description = "A azure_files_authentication block - Azure Files authentication configuration."
  type = object({
    directory_type                 = string           # Specifies the directory service used. Possible values are AADDS, AD and AADKERB
    default_share_level_permission = optional(string) # Specifies the default share level permissions applied to all users. Possible values are StorageFileDataSmbShareReader, StorageFileDataSmbShareContributor, StorageFileDataSmbShareElevatedContributor, or None
    active_directory = optional(object({              # A active_directory block - Required when directory_type is AD
      domain_name         = string                    # Specifies the primary domain that the AD DNS server is authoritative for
      domain_guid         = string                    # Specifies the domain GUID
      domain_sid          = optional(string)          # Specifies the security identifier (SID). This is required when directory_type is set to AD
      storage_sid         = optional(string)          # Specifies the security identifier (SID) for Azure Storage. This is required when directory_type is set to AD
      forest_name         = optional(string)          # Specifies the Active Directory forest. This is required when directory_type is set to AD
      netbios_domain_name = optional(string)          # Specifies the NetBIOS domain name. This is required when directory_type is set to AD
    }))
  })
  default = null
}

variable "routing" {
  description = "A routing block - Network routing configuration."
  type = object({
    publish_internet_endpoints  = optional(bool)   # Should internet routing storage endpoints be published? Defaults to false
    publish_microsoft_endpoints = optional(bool)   # Should Microsoft routing storage endpoints be published? Defaults to false
    choice                      = optional(string) # Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting
  })
  default = null
}

variable "immutability_policy" {
  description = "An immutability_policy block - Account-level immutability policy configuration."
  type = object({
    allow_protected_append_writes = bool   # When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted
    state                         = string # Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time
    period_since_creation_in_days = number # The immutability period for the blobs in the container since the policy creation, in days
  })
  default = null
}

variable "sas_policy" {
  description = "A sas_policy block - SAS policy configuration."
  type = object({
    expiration_period = string           # The SAS expiration period in format of DD.HH:MM:SS
    expiration_action = optional(string) # The SAS expiration action. The only possible value is Log at this moment. Defaults to Log
  })
  default = null
}

