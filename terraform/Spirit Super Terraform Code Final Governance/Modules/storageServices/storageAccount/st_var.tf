# variable.tf
variable "storageAccountName" {
  description = "The name of the Azure Storage Account."
  type        = string

}

variable "accountTier" {
  description = "The storage account tier (Standard or Premium)."
  type        = string

}
variable "rgName" {
  type        = string
  description = "The storage account rg name"
}

variable "location" {
  description = "Storage Account location"

}
variable "accountReplicationType" {
  description = "The storage account replication type (LRS, GRS, RAGRS, ZRS, GZRS, or GZRS)."
  type        = string

}

variable "tags" {
  description = "A map of tags to assign to the Azure Storage Account."
  type        = map(string)

}

variable "isHnsEnabled" {
  description = "hierarchical namespace for storage account"
  type        = bool
}

variable "publicNetworkAccessEnabled" {
  description = "public network access for storage account"
  type        = bool
}

# variable "storageShareName" {
#   description = "The name of the share. Must be unique within the storage account where the share is located."
#   type        = string
# }

# variable "storageShareQuota" {
#   description = "The maximum size of the share, in gigabytes."
#   type        = number
# }

variable "accountKind" {
  description = "Defines the Kind of account."
  type        = string
}

variable "enableHttpsTrafficOnly" {
  description = "Boolean flag which forces HTTPS if enabled"
  type        = bool
  default     = true
}

variable "minTlsVersion" {
  description = "The minimum supported TLS version for the storage account."
  type        = string
  default =   "TLS1_2"
}

variable "sharedAccessKeyEnabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
  default = true
}

# variable "defaultAction" {
#   description = "Specifies the default action of allow or deny when no other rules match."
#   type        = string
#   default = "Allow"
# }

# variable "bypass" {
#   description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices."
#   type        = list(string)
# }

# # variable "virtualNetworkSubnetIds" {
# #   description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices."
# #   type        = list(string)
# # }

# variable "ipRules" {
#   description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices."
#   type        = list(string)
# }

variable "networkRules" {
  type = any
}